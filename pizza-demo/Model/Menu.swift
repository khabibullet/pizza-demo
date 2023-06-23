//
//  Menu.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation
import RealmSwift

struct Menu: Codable, Hashable {
    var city: String
    var promoBanners: [PromoBanner]
    var items: [MenuCategory]
}

class MenuRealm: Object {
    
    @Persisted var city: String = ""
    @Persisted var banners = List<PromoBannerRealm>()
    @Persisted var categories = List<MenuCategoryRealm>()
    
}
