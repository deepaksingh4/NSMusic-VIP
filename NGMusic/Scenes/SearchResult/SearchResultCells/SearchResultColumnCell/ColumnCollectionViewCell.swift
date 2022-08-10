//
//  ColumnCollectionViewCell.swift
//  NGMusic
//
//  Created by Deepak on 06/08/22.
//

import UIKit

protocol MusicCellConfiguration {
    func configureCell(model: MusicResponseModel)
}

class ColumnCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var imageView: CustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ColumnCollectionViewCell: MusicCellConfiguration {
    func configureCell(model: MusicResponseModel) {
        self.collectionTitle.text = model.trackName ?? model.collectionName
        self.imageView.loadImageUsingUrlString(
            url: model.artworkUrl100,
            placeHolderImage: UIImage(named: "placeholder")
        )
        self.author.text = model.artistName
    }
}
