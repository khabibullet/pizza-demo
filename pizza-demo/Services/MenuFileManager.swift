//
//  FileManager.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 23.06.2023.
//

import Foundation

class MenuFileManager {
    
    static let shared = MenuFileManager()
    
    private init() {}
    
    let fileManager = FileManager.default
    let defaultPath = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
    ).first
    
    func createFile(name: String, data: Data) async {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return
        }
        fileManager.createFile(
            atPath: fullPath.path,
            contents: data
        )
    }
    
    func getFile(name: String) async -> Data? {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return nil
        }
        return fileManager.contents(atPath: fullPath.path)
    }
    
    func removeFile(name: String) async {
        guard let fullPath = defaultPath?.appendingPathComponent(name) else {
            return
        }
        try? fileManager.removeItem(at: fullPath)
    }
    
    func removeFile(atPath path: String) async {
        try? fileManager.removeItem(atPath: path)
    }
    
    func getListOfFiles(with suffix: String) async -> [String] {
        if  let defaultPath,
            let filtered = try? fileManager
                .contentsOfDirectory(atPath: defaultPath.path)
                .filter({ $0.hasSuffix(suffix) }) {
            return filtered
        }
        return []
    }
    
}
