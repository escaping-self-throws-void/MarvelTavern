//
//  String+Extensions.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation
import CryptoKit

extension String {
    var MD5: String {
        let data = self.data(using: .utf8) ?? Data()
        let hash = Insecure.MD5.hash(data: data)
        
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
    
    var https: String {
        replacingOccurrences(of: "http", with: "https")
    }
}
