//
//  DJDecoder.swift
//  Checker
//
//  Created by polaris dev on 2023/1/12.
//

import Foundation

struct DJDecoder {
    
    let data: Data
    
    let decoder = JSONDecoder()
    
    init(_ data: Data) {
        self.data = data
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T: Codable>() -> T? {
        return try? decoder.decode(T.self, from: data)
    }
    
}

struct DJEncoder {
    
    let value: Codable
    let encoder = JSONEncoder()
    
    init(_ value: Codable) {
        self.value = value
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    func encode() -> [String: Any] {
        guard let data = try? encoder.encode(value),
              let d = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return [:] }
        return d
    }
}
