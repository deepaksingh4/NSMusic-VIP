//
//  SearchResultViewControllerTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

import XCTest
@testable import NGMusic

private class SearchResultBusinessLogicSpy: SearchResultBusinessLogic {
    var updateMusicCalled = false
    func updateMusic() {
        updateMusicCalled = true
    }
}

class SearchResultViewControllerTests: XCTestCase {

    var sut: SearchResultViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSearchResultViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func setupSearchResultViewController() {
        sut = UINib.searchResultViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    func testShouldDoSomethingWhenViewIsLoaded() {
        let spy = SearchResultBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        XCTAssertTrue(spy.updateMusicCalled, "viewDidLoad() should ask the interactor to do something")
    }

    func testLayoutChange() {
        loadView()
        let segment = UISegmentedControl()
        segment.selectedSegmentIndex = 0
        sut.changeLayout(segment)
        XCTAssertEqual(sut.controllerLayout, SearchResultViewController.Layout.grid, "Layout selection not working")
    }

    func testLoadData() {
      let interactor = SearchResultInteractor()
        interactor.searchResult = [[MusicResponseModel(
            trackName: "AA",
            artistName: "BB",
            artistViewUrl: nil,
            artworkUrl100: nil,
            collectionName: nil,
            wrapperType: .album,
            kind: nil,
            collectionPrice: nil,
            copyright: nil,
            country: nil,
            currency: nil,
            releaseDate: nil,
            previewUrl: nil,
            collectionViewUrl: nil
        )]]

        interactor.resultTypes = ["Album"]

        let presenter = SearchResultPresenter()
        presenter.viewController = sut
        interactor.presenter = presenter
        sut.interactor = interactor

        loadView()
        XCTAssertEqual(sut.resultTypes?.count, 1, "Result type is not passed")

    }

}
