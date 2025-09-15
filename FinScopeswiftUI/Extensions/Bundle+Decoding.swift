//
//  bundle+decoding.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 01/07/2025.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("❌ Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("❌ Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("❌ Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

