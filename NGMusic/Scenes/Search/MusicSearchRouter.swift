//
//  MusicSearchRouter.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.

import UIKit

@objc protocol MusicSearchRoutingLogic {
    func routeToResult()
}

protocol MusicSearchDataPassing {
  var dataStore: MusicSearchDataStore? { get }
}

class MusicSearchRouter: NSObject, MusicSearchRoutingLogic, MusicSearchDataPassing {
  weak var viewController: MusicSearchViewController?
  var dataStore: MusicSearchDataStore?
  // MARK: Routing
    func routeToResult() {
        let searchResultVC = UINib.searchResultViewController
        if var searchResultDS = searchResultVC.router?.dataStore, let searchDataStore = dataStore {
            passDataToResultScreen(source: searchDataStore, destination: &searchResultDS)
        }
        viewController?.navigationController?.pushViewController(searchResultVC, animated: true)
    }

    func passDataToResultScreen(source: MusicSearchDataStore, destination: inout SearchResultDataStore) {
        destination.searchResult = source.searchResult
        destination.resultTypes = source.resultTypes
    }
}
