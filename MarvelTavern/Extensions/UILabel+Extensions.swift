//
//  UILabel+Extensions.swift
//  MarvelTavern
//
//  Created by Paul Matar on 26/12/2022.
//

import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineHeight
        attributeString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSMakeRange(0, attributeString.length)
        )
        self.attributedText = attributeString
    }
}
