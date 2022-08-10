//
//  UINIb+Helper.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.
//

import Foundation
import UIKit

extension UINib {
    class var musicSearchViewContrller: MusicSearchViewController {
        return MusicSearchViewController(nibName: NibConstants.MusicSearchVC, bundle: Bundle.main)
    }
    class var searchResultViewController: SearchResultViewController {
        return SearchResultViewController(nibName: NibConstants.SearchResultVC, bundle: Bundle.main)
    }
    class var musicDetailsViewController: MusicDetailViewController {
        return MusicDetailViewController(nibName: NibConstants.MusicDetailVC, bundle: Bundle.main)
    }
}

struct NibConstants {
    static let MusicSearchVC = "MusicSearchViewController"
    static let SearchResultVC = "SearchResultViewController"
    static let MusicDetailVC = "MusicDetailViewController"
    static let GridCell = "SearchResultGridCollectionViewCell"
    static let ColumnCell = "ColumnCollectionViewCell"
    static let Header = "HeaderViewCollectionReusableView"
}
