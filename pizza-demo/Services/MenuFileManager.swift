//
//  FileManager.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 23.06.2023.
//

import Foundation

struct MenuFileManager {
    
    static let defaultPath = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
    ).first
    
    static func createFile(name: String, data: Data) async {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return
        }
        FileManager().createFile(
            atPath: fullPath.path,
            contents: data
        )
    }
    
    static func getFile(name: String) async -> Data? {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return nil
        }
        return FileManager().contents(atPath: fullPath.path)
    }
    
    static func removeFile(name: String) async {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return
        }
        try? FileManager().removeItem(at: fullPath)
    }
    
    static func removeFile(atPath path: String) async {
        try? FileManager().removeItem(atPath: path)
    }
    
    static func getListOfFiles(with suffix: String) async -> [String] {
        if  let defaultPath,
            let filtered = try? FileManager()
                .contentsOfDirectory(atPath: defaultPath.path)
                .filter({ $0.hasSuffix(suffix) }) {
            return filtered
        }
        return []
    }
    
}
