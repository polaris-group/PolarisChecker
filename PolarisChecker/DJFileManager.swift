//
//  DJFileManager.swift
//  Checker
//
//  Created by polaris dev on 2023/1/12.
//

import Foundation

struct DJFileManager {
    
    static let `default` = DJFileManager()
    
    func loadBundleJSONFile<T: Codable>(_ filename: String) -> T? {
        return DJDecoder(loadBundleData(filename)).decode()
    }
    
    func loadBundleData(_ filename: String) -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            return try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
}
