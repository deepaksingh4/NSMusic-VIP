//
//  MusicSearchInteractorTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

@testable import NGMusic
import XCTest

class MusicSearchInteractorTests: XCTestCase {
  var sut: MusicSearchInteractor!

  override func setUp() {
    super.setUp()
    setupMusicSearchInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  func setupMusicSearchInteractor() {
      let musicService = MusicService(apiClient: SearchClientAPIMock())
      let presenter = MusicSearchPresenter()
      sut = MusicSearchInteractor(movieService: musicService, presenter: presenter)
  }

  func testSeach() {
      sut.fetchMusic(queryString: "A", entity: Set(["Album"]))
//      let expectation = XCTestExpectation(description: "waiting for response")
//      expectation.fulfill()
//      wait(for: [expectation], timeout: 1)
      XCTAssertTrue(sut.searchResult.count == 1, "No result found")
  }
}
