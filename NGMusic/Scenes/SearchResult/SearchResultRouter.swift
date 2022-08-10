//
//  SearchResultRouter.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

@objc protocol SearchResultRoutingLogic {
    func routeToDetails(forIndexPath: IndexPath)
}

protocol SearchResultDataPassing {
  var dataStore: SearchResultDataStore? { get }
}

class SearchResultRouter: NSObject, SearchResultRoutingLogic, SearchResultDataPassing {
  weak var viewController: SearchResultViewController?
  var dataStore: SearchResultDataStore?

  func routeToDetails(forIndexPath: IndexPath) {

      let detailVC = UINib.musicDetailsViewController
      if var detailDS = detailVC.router?.dataStore, let searchDataStore = dataStore {
          let val = searchDataStore.searchResult[forIndexPath.section][forIndexPath.row]
          passDataToDetailScreen(data: val, destination: &detailDS)
      }
      viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }

  // MARK: Passing data

  func passDataToDetailScreen(data: MusicResponseModel, destination: inout MusicDetailDataStore) {
      destination.musicModel = data
  }
}
