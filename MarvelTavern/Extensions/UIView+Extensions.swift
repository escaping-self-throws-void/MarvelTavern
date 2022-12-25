//
//  UIView+Extensions.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import UIKit

extension UIView {
    func shimmer(with color: UIColor = .clear, roundedCorners: CGFloat = 15) {
        let containerView = UIView()
        containerView.layer.cornerRadius = roundedCorners
        containerView.frame = bounds
        containerView.backgroundColor = color

        let light = UIColor(white: 1, alpha: 0.5).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, light, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]

        gradient.frame = containerView.bounds

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]

        animation.repeatCount = .infinity
        animation.duration = 1.1
        animation.isRemovedOnCompletion = false

        gradient.add(animation, forKey: "shimmer")
        
        containerView.layer.addSublayer(gradient)
        addSubview(containerView)
    }
}
