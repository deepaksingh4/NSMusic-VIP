//
//  MusicSearchInteractor.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.

import UIKit

protocol MusicSearchBusinessLogic {
    func fetchMusic(queryString: String?, entity: Set<String>)
}

protocol MusicSearchDataStore {
    var searchResult: [[MusicResponseModel]] { get }
    var resultTypes: [String] { get }
}

class MusicSearchInteractor: MusicSearchBusinessLogic, MusicSearchDataStore {
    let presenter: MusicSearchPresentationLogic
    var musicService: MusicServiceProtocol?
    var searchResult: [[MusicResponseModel]] = []
    var resultTypes: [String] = []

    init(movieService: MusicServiceProtocol = MusicService.init(), presenter: MusicSearchPresentationLogic) {
        self.musicService = movieService
        self.presenter = presenter
    }

    func fetchMusic(queryString: String?, entity: Set<String>) {

        let valid = isSearchQueryValid(queryString: queryString, entity: entity)
        if valid.0 {

            self.searchResult.removeAll()
            self.resultTypes.removeAll()
            let group = DispatchGroup()

            for item in entity {
                let typeM = item.trimmingCharacters(in: .whitespacesAndNewlines)
                let mediaType = MediaType(rawValue: typeM)!
                group.enter()
                musicService?.searchMovie(query: queryString!,
                                          entity: mediaType.key,
                                          success: { (matchingMusicResponse) in
                    guard let music = matchingMusicResponse.results else {
                        group.leave()
                        return
                    }
                    self.searchResult.append(music)
                    self.resultTypes.append(typeM)
                    group.leave()
                }, failure: { (_, _) in
                    group.leave()
                })
            }

            group.notify(queue: DispatchQueue.main) {
                self.searchResult.isEmpty
                ? self.presenter.showError(message: Constants.SearchScreen.somethingWrong)
                : self.presenter.showResult(musics: self.searchResult, types: self.resultTypes)
            }
        } else {
            presenter.showError(message: valid.1)
        }
    }

   private func isSearchQueryValid(queryString: String?, entity: Set<String>) -> (Bool, String) {
        guard let query = queryString else {
            return (false, Constants.SearchScreen.inValidSearchKey)
        }
        let trancateQuery = query.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if trancateQuery.isEmpty {
            return (false, Constants.SearchScreen.inValidSearchKey)
        }

        if entity.isEmpty {
            return (false, Constants.SearchScreen.inValidSearchEntity)
        }

        return (true, "")
    }
}
