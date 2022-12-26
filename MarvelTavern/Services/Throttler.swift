//
//  Throttler.swift
//  MarvelTavern
//
//  Created by Paul Matar on 26/12/2022.
//

import Foundation

final class Throttler {
    
    static let shared = Throttler()
    
    private init() {}
    
    private var timer: Timer?
    
    func throttle(for sec: TimeInterval, _ completion: @escaping () -> Void) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: sec, repeats: false, block: { _ in
            completion()
        })
    }
}
