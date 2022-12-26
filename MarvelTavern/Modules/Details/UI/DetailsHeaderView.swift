//
//  DetailsHeaderView.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import UIKit

final class DetailsHeaderView: UICollectionReusableView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: C.Fonts.marvelFont, size: 24)
        label.textColor = .init(named: C.Colors.marvelRed)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func layoutViews() {
        titleLabel.place(on: self).pin(
            .leading(padding: 15),
            .trailing(padding: 15),
            .bottom(padding: 5),
            .top(padding: 5)
        )
    }
}

