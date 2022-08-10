//
//  MusicSearchPresenter.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.

import UIKit

protocol MusicSearchPresentationLogic {
    func showError(message: String)
    func showResult(musics: [[MusicResponseModel]], types: [String])
}

class MusicSearchPresenter: MusicSearchPresentationLogic {
    weak var viewController: MusicSearchDisplayLogic?

    func showError(message: String) {
        viewController?.showErrorWithMessage(message: message)
    }

    func showResult(musics: [[MusicResponseModel]], types: [String]) {
        let successViewModel = MusicSearch.init(musics: musics, types: types)
        viewController?.showResultScreenWith(viewModel: successViewModel)
    }
}
