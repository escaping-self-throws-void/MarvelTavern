//
//  UICollectionReusableView+Extensions.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import UIKit

extension UICollectionReusableView {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
