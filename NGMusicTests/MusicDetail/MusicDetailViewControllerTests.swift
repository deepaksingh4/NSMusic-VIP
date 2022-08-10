//
//  MusicDetailViewControllerTests.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.

@testable import NGMusic
import XCTest

class MusicDetailViewControllerTests: XCTestCase {
  // MARK: Subject under test

  var sut: MusicDetailViewController!
  var window: UIWindow!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupMusicDetailViewController()
  }

  override func tearDown() {
    window = nil
    super.tearDown()
  }

  // MARK: Test setup

  func setupMusicDetailViewController() {
      sut = UINib.musicDetailsViewController
  }

  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }

  // MARK: Test doubles

  class MusicDetailBusinessLogicSpy: MusicDetailBusinessLogic {
    var updateDetailCalled = false

      func updateDetail() {
          updateDetailCalled = true
      }
  }

  func testShouldDoSomethingWhenViewIsLoaded() {
    let spy = MusicDetailBusinessLogicSpy()
    sut.interactor = spy
    loadView()
    XCTAssertTrue(spy.updateDetailCalled, "viewDidLoad() should ask the interactor to do something")
  }

}
