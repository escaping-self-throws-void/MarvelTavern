//
//  NotFoundView.swift
//  MarvelTavern
//
//  Created by Paul Matar on 26/12/2022.
//

import UIKit

final class NotFoundView: UIView {
    
    private lazy var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.Text.notFound
        lbl.numberOfLines = 0
        lbl.setLineHeight(10)
        lbl.font = UIFont(name: C.Fonts.marvelFont, size: 30)
        lbl.textColor = UIColor(named: C.Colors.marvelRed)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var imageView: UIImageView = {
        let gifImage = UIImage.animatedGif(named: C.Images.notFound,
                                            framesPerSecond: 15)
        let view = UIImageView(image: gifImage)
        view.sizeToFit()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    private func layoutViews() {
        messageLabel.place(on: self).pin(
            .top,
            .trailing(padding: 20),
            .leading(padding: 20)
        )
        
        imageView.place(on: self).pin(
            .top(to: messageLabel, .bottom, padding: 10),
            .trailing,
            .leading,
            .height(to: self, padding: -50)
        )
    }
}
