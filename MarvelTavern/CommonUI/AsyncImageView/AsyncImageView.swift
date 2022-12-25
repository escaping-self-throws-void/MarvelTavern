//
//  AsyncImageView.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class AsyncImageView: UIImageView {
    
    private var imageUrl: String? {
        didSet {
            dowloadImage()
        }
    }
            
    func setImage(_ imageUrl: String?, placeholder: UIImage?) {
        self.image = placeholder
        self.imageUrl = imageUrl
    }
    
    private func dowloadImage() {
        guard let imageUrl else { return }
        
        Task { @MainActor in
            do {
                let loadedImage = try await ImageLoader.shared.downloadImage(from: imageUrl)
                if imageUrl == self.imageUrl {
                    image = loadedImage
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}
