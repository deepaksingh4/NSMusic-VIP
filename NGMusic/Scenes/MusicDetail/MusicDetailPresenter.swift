//
//  MusicDetailPresenter.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

protocol MusicDetailPresentationLogic {
    func present(item: MusicResponseModel)
}

class MusicDetailPresenter: MusicDetailPresentationLogic {
  weak var viewController: MusicDetailDisplayLogic?

  // MARK: Do something

    func present(item: MusicResponseModel) {

        let vm = prepareViewModel(from: item)
        self.viewController?.displayInfo(viewModel: vm)
    }

    func prepareViewModel(from musicModel: MusicResponseModel) -> MusicDetail.LoadResultDetails.ViewModel {
        let vm = MusicDetail.LoadResultDetails.ViewModel(
            image: musicModel.artworkUrl100,
            title: musicModel.trackName ?? musicModel.collectionName ?? "",
            mediaURL: musicModel.previewUrl,
            link: musicModel.collectionViewUrl
        )
        return vm
    }
}
