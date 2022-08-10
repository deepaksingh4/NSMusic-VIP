//
//  String+Localizable.swift
//  NGMusic
//
//  Created by Deepak on 02/08/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var actual: String {
        return self
    }
}
