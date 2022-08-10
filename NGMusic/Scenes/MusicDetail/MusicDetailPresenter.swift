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
        self.viewController?.displayInfo(viewModel: item)
    }
}
