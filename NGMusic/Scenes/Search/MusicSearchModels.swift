//
//  MusicSearchModels.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.

import UIKit

struct MusicSearch {
    var musics: [[MusicResponseModel]]
    var types: [String]

    init(musics: [[MusicResponseModel]], types: [String]) {
        self.musics = musics
        self.types = types
    }
}
