//
//  MenuCategory.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation
import RealmSwift

struct MenuCategory: Codable {
    
    var id: UUID
    var title: String
    var items: [MenuItem]
    
}

class MenuCategoryRealm: EmbeddedObject {
    
    @Persisted var categoryTitle: String
    @Persisted var items = List<MenuItemRealm>()
    
}
