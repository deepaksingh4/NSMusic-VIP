//
//  MusicDetailInteractorTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

 @testable import NGMusic
 import XCTest

 class MusicDetailInteractorTests: XCTestCase {
  // MARK: Subject under test

  var sut: MusicDetailInteractor!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupMusicDetailInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupMusicDetailInteractor() {
    sut = MusicDetailInteractor()
  }

  // MARK: Test doubles

  class MusicDetailPresentationLogicSpy: MusicDetailPresentationLogic {
    var presentMusicCalled = false

      func present(item: MusicResponseModel) {
      presentMusicCalled = true
    }
  }

  // MARK: Tests

  func testDoSomething() {
    let spy = MusicDetailPresentationLogicSpy()
    sut.presenter = spy
    let model = MusicResponseModel(trackName: "AA",
                                   artistName: "Some name",
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
    )
    sut.musicModel = model
    sut.updateDetail()
    XCTAssertTrue(spy.presentMusicCalled, "updateDetail should ask the presenter to format the result")
  }
 }
