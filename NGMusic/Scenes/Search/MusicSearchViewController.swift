//
//  MusicSearchViewController.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.

import UIKit

protocol MusicSearchDisplayLogic: AnyObject {
    func showResultScreenWith(viewModel: MusicSearch)
    func showErrorWithMessage(message: String)
}

class MusicSearchViewController: UIViewController, MusicSearchDisplayLogic {
    var interactor: MusicSearchBusinessLogic?
    var router: (NSObjectProtocol & MusicSearchRoutingLogic & MusicSearchDataPassing)?
    var selectedCategories: Set<String> = Set(minimumCapacity: 0)

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let presenter = MusicSearchPresenter()
        let interactor = MusicSearchInteractor(presenter: presenter)
        let router = MusicSearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()
    }

    // MARK: Do something

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchMediaLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func showResultScreenWith(viewModel: MusicSearch) {
        stopProgressBar()
        router?.routeToResult()
    }

    func showErrorWithMessage(message: String) {
        stopProgressBar()
        showErrorAlertWith(message: message)
    }

    func showProgressBar() {
        self.activityIndicator.startAnimating()
    }
    func stopProgressBar() {
        self.activityIndicator.stopAnimating()
    }
    @IBAction  func selectCategory(sender: UIButton) {
        let title = sender.title(for: .init())!
        if selectedCategories.contains(title) {
            sender.backgroundColor = .white
            sender.setTitleColor(.gray, for: .init())
            selectedCategories.remove(title)
        } else {
            sender.backgroundColor = .gray
            sender.setTitleColor(.white, for: .init())
            selectedCategories.insert(title)
        }
    }

    @IBAction func search(sender: UIButton) {
        searchMusic(queryString: searchTextField.text, entity: selectedCategories)
    }

    func searchMusic(queryString: String?, entity: Set<String>) {
        showProgressBar()
        interactor?.fetchMusic(queryString: queryString, entity: entity)
    }

    func showErrorAlertWith(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive)
        alertVC.addAction(okButton)
        self.present(alertVC, animated: true)
    }
}
