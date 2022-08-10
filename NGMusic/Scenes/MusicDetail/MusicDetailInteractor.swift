//
//  MusicDetailInteractor.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.

import UIKit

protocol MusicDetailBusinessLogic {
    func updateDetail()
}

protocol MusicDetailDataStore {
    var musicModel: MusicResponseModel! {get set}
}

class MusicDetailInteractor: MusicDetailBusinessLogic, MusicDetailDataStore {
    var musicModel: MusicResponseModel!
    var presenter: MusicDetailPresentationLogic?

    func updateDetail() {
        presenter?.present(item: musicModel)
    }
}
