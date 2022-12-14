//
//  MusicSearchViewControllerTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import NGMusic
import XCTest

private class MusicSearchBusinessLogicSpy: MusicSearchBusinessLogic {
    var musicSearchCalled = false
    func fetchMusic(queryString: String?, entity: Set<String>) {
        musicSearchCalled = true
    }
}

class MusicSearchViewControllerTests: XCTestCase {
    // MARK: Subject under test

    var sut: MusicSearchViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMusicSearchViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMusicSearchViewController() {
        sut = UINib.musicSearchViewContrller
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    func testCheckSearch() {
        let spy = MusicSearchBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.searchMusic(queryString: "A", entity: Set(["Book"]))
        XCTAssertTrue(spy.musicSearchCalled, "VC should ask the interactor to do search")
    }

    func testCheckSearchButtonClick() {
        let spy = MusicSearchBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.searchTextField.text = "A"
        sut.selectedCategories = Set(["Book"])
        sut.search(sender: UIButton())

        XCTAssertTrue(spy.musicSearchCalled, "VC should ask the interactor to do search")
    }
}
