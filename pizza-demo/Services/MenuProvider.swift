//
//  MenuProvider.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

class MenuProvider {
    
    static let shared = MenuProvider()
    
    private init() {}
    
    let menuURL = URL(string: "https://raw.githubusercontent.com/khabibullet/pizza-demo/master/contents/pizza-demo-data.json")!
    
    func fetchMenu() async -> Menu? {
        let request = URLRequest(url: menuURL)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let menu = try JSONDecoder().decode(Menu.self, from: data)
            Task {
                await persistMenu(menu: menu)
            }
            return menu
        } catch {
            return getPersistedMenu()
        }
    }
    
    func getPersistedMenu() -> Menu? {
        guard
            let fileUrl = Bundle.main.url(
                forResource: "pizza-demo-model", withExtension: "json"
            ),
            let data = try? Data(contentsOf: fileUrl),
            var menu = try? JSONDecoder().decode(Menu.self, from: data)
        else {
            return nil
        }
        for (id, banner) in menu.promoBanners.enumerated() {
            switch banner.imageUrl {
            case .local(let url), .remote(let url):
                menu.promoBanners[id].imageUrl = .local(url)
            }
        }
        for (categoryId, category) in menu.items.enumerated() {
            for (itemId, item) in category.items.enumerated() {
                switch item.imageUrl {
                case .local(let url), .remote(let url):
                    menu.items[categoryId].items[itemId].imageUrl = .local(url)
                }
            }
        }
        return menu
    }
    
    func persistMenu(menu: Menu) async {
        guard
            let fileUrl = Bundle.main.url(
                forResource: "pizza-demo-model", withExtension: "json"
            ),
            let data = try? JSONEncoder().encode(menu),
            let _ = try? data.write(to: fileUrl)
        else {
            return
        }
    }
    
}
