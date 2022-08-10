//
//  SearchResultInteractor.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

protocol SearchResultBusinessLogic {
    func updateMusic()
}

protocol SearchResultDataStore {
    var searchResult: [[MusicResponseModel]] { get set}
    var resultTypes: [String] { get set }
}

class SearchResultInteractor: SearchResultBusinessLogic, SearchResultDataStore {
    var presenter: SearchResultPresentationLogic?
    var searchResult: [[MusicResponseModel]] = []
    var resultTypes: [String] = []

    func updateMusic() {
        self.presenter?.showResult(items: searchResult, types: resultTypes)
    }
}
