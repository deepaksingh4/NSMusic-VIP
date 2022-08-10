//
//  SearchResultPresenter.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

protocol SearchResultPresentationLogic {
    func showResult(items: [[MusicResponseModel]], types: [String])
}

class SearchResultPresenter: SearchResultPresentationLogic {
  weak var viewController: SearchResultDisplayLogic?

  // MARK: Do something

    func showResult(items: [[MusicResponseModel]], types: [String]) {
      self.viewController?.showResult(items: items, types: types)
  }
}
