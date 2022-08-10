//
//  CircularButton.swift
//  NGMusic
//
//  Created by Deepak on 04/08/22.
//

import UIKit

class CircularBtton: UIButton {

    override var isSelected: Bool {
       didSet {
            if oldValue {
                self.tintColor = .darkGray
            } else {
                self.tintColor = .lightGray
            }
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        updateUI()
    }

    func updateUI() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }

}
