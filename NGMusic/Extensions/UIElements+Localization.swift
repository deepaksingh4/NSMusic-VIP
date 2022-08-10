//
//  UIElements+Localization.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable
    var localizedKey: String {
        get {
            return ""
        }
        set(key) {
            text = key.localized
        }
    }
}

extension UIButton {
    @IBInspectable
    var localizedKey: String {
        get {
            return ""
        }
        set(key) {
            setTitle(key.localized, for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable
    var localizedKey: String {
        get {
            return ""
        }
        set(key) {
            placeholder = key.localized
        }
    }
}

extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
