//
//  CustomImageView.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrlString(url: URL? = nil, placeHolderImage: UIImage? = UIImage(named: "placeholder")) {

        self.image = nil

        if url == nil {
            self.image = UIImage(named: "placeholder")
            return
        }

        let urlString = url!.relativeString
        imageUrlString = urlString
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url!) { (data, _, _) in

            DispatchQueue.main.async {
                guard let safeData = data,
                      let downloadedImage = UIImage.init(data: safeData) else {
                    self.setImageWithAnimation(imageToTransition: UIImage(named: "artist"))
                    return
                }

                if self.imageUrlString == urlString {
                    self.setImageWithAnimation(imageToTransition: downloadedImage)
                }

                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
            }
        }
        dataTask.resume()
    }

    private func setImageWithAnimation(imageToTransition: UIImage?) {
        UIView.transition(with: self,
                          duration: 0.50,
                          options: .transitionCrossDissolve,
                          animations: { self.image = imageToTransition },
                          completion: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.tintColor = .white
    }

}
