//
//  MusicDetailPresenterTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

 @testable import NGMusic
 import XCTest

 class MusicDetailPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: MusicDetailPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupMusicDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupMusicDetailPresenter() {
    sut = MusicDetailPresenter()
  }

  // MARK: Test doubles

  class MusicDetailDisplayLogicSpy: MusicDetailDisplayLogic {
    var displaySomethingCalled = false

    func displayInfo(viewModel: MusicResponseModel) {
      displaySomethingCalled = true
    }
  }

  // MARK: Tests

  func testPresentSomething() {
    let spy = MusicDetailDisplayLogicSpy()
    sut.viewController = spy
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
    sut.present(item: model)
    XCTAssertTrue(spy.displaySomethingCalled, "preset model should ask the view controller to display the result")
  }
 }
