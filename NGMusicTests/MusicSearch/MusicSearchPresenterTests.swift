//
//  MusicSearchPresenterTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

@testable import NGMusic
import XCTest

private class MusicSearchDisplayLogicSpy: MusicSearchDisplayLogic {

    var showResultCalled = false
    var showErrorcalled = false

    func showResultScreenWith(viewModel: MusicSearch) {
        showResultCalled = true
    }
    func showErrorWithMessage(message: String) {
        showErrorcalled = true
    }
}

class MusicSearchPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: MusicSearchPresenter!

    override func setUp() {
        super.setUp()
        setupMusicSearchPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    func setupMusicSearchPresenter() {
        sut = MusicSearchPresenter()
    }

    func testSearcShowResult() {
        let spy = MusicSearchDisplayLogicSpy()
        sut.viewController = spy

        sut.showResult(musics: [[]], types: ["album"])

        XCTAssertTrue(spy.showResultCalled, "Result method failed to call")
    }

    func testSearcShowError() {
        let spy = MusicSearchDisplayLogicSpy()
        sut.viewController = spy

        sut.showError(message: "Got error")

        XCTAssertTrue(spy.showErrorcalled, "Result method failed to call")
    }
}
