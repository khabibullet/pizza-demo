//
//  Menu.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

struct Menu: Codable, Hashable {
    
    var city: String
    var promoBanners: [PromoBanner]
    var items: [MenuCategory]
    
}
