//
//  SearchResultViewController.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

protocol SearchResultDisplayLogic: AnyObject {
    func showResult(items: [[MusicResponseModel]], types: [String])
}

class SearchResultViewController: UIViewController, SearchResultDisplayLogic {

    private enum CellIds: String {
        case grid = "gridCell"
        case column = "columnCell"
        case header = "header"
    }
    enum Layout: Int {
        case grid
        case single
    }
    var interactor: SearchResultBusinessLogic?
    var router: (NSObjectProtocol & SearchResultRoutingLogic & SearchResultDataPassing)?
    private(set) var controllerLayout: Layout = .grid
    private(set) var searchedItems: [[MusicResponseModel]]?
    private(set) var resultTypes: [String]?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter()
        let router = SearchResultRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func changeLayout(_ sender: UISegmentedControl) {
        updateLayout(layout: Layout(rawValue: sender.selectedSegmentIndex) ?? .grid)
    }

    private func updateLayout(layout: Layout) {
        self.controllerLayout = layout
        self.collectionView.reloadData()
    }
    func setupUI() {
        self.title = "ITUNES".localized
        interactor?.updateMusic()
        initCollectionView()
    }

    private func initCollectionView() {
        let gridCell = UINib(nibName: NibConstants.GridCell, bundle: nil)
        let columnCell = UINib(nibName: NibConstants.ColumnCell, bundle: nil)
        let header = UINib(nibName: NibConstants.Header, bundle: nil)
        collectionView.register(gridCell, forCellWithReuseIdentifier: CellIds.grid.rawValue)
        collectionView.register(columnCell, forCellWithReuseIdentifier: CellIds.column.rawValue)
        collectionView.register(
            header,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CellIds.header.rawValue
        )
        collectionView.dataSource = self
    }

    func showResult(items: [[MusicResponseModel]], types: [String]) {
        searchedItems = items
        resultTypes = types
        self.collectionView.reloadData()
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  searchedItems?[section].count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchedItems?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CellIds.header.rawValue,
                for: indexPath) as? HeaderViewCollectionReusableView else {
                return collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: CellIds.header.rawValue,
                    for: indexPath)
            }

            headerView.titleLabel.text = resultTypes?[indexPath.section] ?? "--"
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        switch controllerLayout {
        case .grid:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIds.grid.rawValue,
                for: indexPath) as? SearchResultGridCollectionViewCell else {
                return UICollectionViewCell()
            }
            configCell(indexPath: indexPath, cell: cell)
            return cell
        case .single:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIds.column.rawValue,
                for: indexPath) as? ColumnCollectionViewCell else {
                return UICollectionViewCell()
            }
            configCell(indexPath: indexPath, cell: cell)
            return cell
        }
    }
    func configCell(indexPath: IndexPath, cell: MusicCellConfiguration ) {
        guard let musicFile = router?.dataStore?.searchResult[indexPath.section][indexPath.row] else {
            return
        }
        cell.configureCell(model: musicFile)
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToDetails(forIndexPath: indexPath)
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var width = self.collectionView.frame.width/3 - 30
        var height = width * 1.2
        if controllerLayout == .single {
            width = self.collectionView.frame.width
            height = 90
        }
        return CGSize(width: width, height: height)
    }
}
