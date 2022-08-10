//
//  NGNavigationViewController.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.
//

import UIKit

class NGNavigationViewController: UINavigationController {

    enum Position {
        case left
        case right
    }

    enum BarButtonImages {
        static let link = UIImage(systemName: "link")
        static let save = UIImage(systemName: "square.and.arrow.down")

    }
    enum BarButtonType {
        case search (callBack: UIAction?)
        case save (callBack: UIAction?)

        func barButton() -> UIBarButtonItem {
            switch self {
            case .search(let callBack):
                return prepareBarButton(image: BarButtonImages.link, callBack: callBack)
            case .save(let callBack):
                return prepareBarButton(image: BarButtonImages.save, callBack: callBack)
            }
        }
        private func prepareBarButton(
            image: UIImage? = UIImage(systemName: "magnifyingglass"),
            title: String? = nil,
            callBack: UIAction? = nil
        ) -> UIBarButtonItem {
            let barButton = UIBarButtonItem(title: title, image: image, primaryAction: callBack, menu: nil)
            barButton.tintColor = .blue
            return barButton
        }

    }

    override func viewDidLoad() {
        setupStyle()
    }

    private func setupStyle() {
        self.navigationBar.barStyle = .default
        self.navigationBar.isTranslucent = false

    }

    func addBarButtonItem(barButtonType: BarButtonType, position: Position) {
        let button = barButtonType.barButton()
        guard let topVC = self.topViewController else {
            return
        }
        switch position {
        case .left:
            topVC.navigationItem.setLeftBarButton(button, animated: false)
        case .right:
            topVC.navigationItem.setRightBarButton(button, animated: false)
        }
    }

}
