//
//  SearchResultGridCollectionViewCell.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//

import UIKit

class SearchResultGridCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var cellTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension SearchResultGridCollectionViewCell: MusicCellConfiguration {
    func configureCell(model: MusicResponseModel) {
        self.cellTitle.text = model.trackName ?? model.collectionName
        self.imageView.loadImageUsingUrlString(
            url: model.artworkUrl100,
            placeHolderImage: UIImage(named: "placeholder")
        )
    }
}
