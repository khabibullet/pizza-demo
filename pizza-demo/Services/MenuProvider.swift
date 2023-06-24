//
//  MenuProvider.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

class MenuProvider {
    
    static let shared = MenuProvider()
    
    private init() {}
    
    let menuURL = URL(string: "https://raw.githubusercontent.com/khabibullet/pizza-demo/master/contents/pizza-demo-data.json")!
    
    let fileManager = MenuFileManager.shared
    
    func fetchMenu() async -> Menu? {
        do {
            return try await fetchRemoteMenu()
        } catch {
            do {
                return try await fetchLocalMenu()
            } catch {
                return nil
            }
        }
    }
    
    func fetchRemoteMenu() async throws -> Menu {
        let request = URLRequest(url: menuURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let menu = try JSONDecoder().decode(Menu.self, from: data)
        Task {
            try await updateLocalMenu(newMenu: menu)
        }
        return menu
    }
    
    func fetchLocalMenu() async throws -> Menu? {
        guard let data = await fileManager.getFile(name: "menu.json") else { return nil }
        return try JSONDecoder().decode(Menu.self, from: data)
    }
    
    func updateLocalMenu(newMenu: Menu) async throws {
        try await updateMenuJson(newMenu: newMenu)
        await updateMenuImages(newMenu: newMenu)
    }
    
    func updateMenuJson(newMenu: Menu) async throws {
        let data = try JSONEncoder().encode(newMenu)
        await fileManager.createFile(name: "menu.json", data: data)
    }
    
    func updateMenuImages(newMenu: Menu) async {
        var newImages = Set<UUID>()
    
        for banner in newMenu.promoBanners {
            newImages.insert(banner.id)
        }
        for category in newMenu.items {
            for item in category.items {
                newImages.insert(item.id)
            }
        }
        let oldImages = await MenuFileManager.shared.getListOfFiles(with: ".png")
            .compactMap({ UUID(uuidString: String($0.suffix(40).prefix(36))) })
        
        for image in oldImages {
            if !newImages.contains(image) {
                await removeLocalImage(uuid: image)
            }
        }
    }
    
    func createLocalImage(uuid: UUID, data: Data) async {
        await fileManager.createFile(name: uuid.uuidString + ".png", data: data)
    }
    
    func removeLocalImage(uuid: UUID) async {
        await fileManager.removeFile(name: uuid.uuidString + ".png")
    }
    
    func getImage(uuid: UUID, url: String) async -> UIImage? {
        if let data = await fileManager.getFile(name: uuid.uuidString + ".png") {
            return UIImage(data: data)
        } else {
            guard let imageUrl = URL(string: url) else { return nil }
            let request = URLRequest(url: imageUrl)
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                await createLocalImage(uuid: uuid, data: data)
                return UIImage(data: data)
            } catch {
                return nil
            }
        }
    }
    
}
