//
//  MenuCategory.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

struct MenuCategory: Codable, Hashable {
    
    var id: UUID
    var title: String
    var items: [MenuItem]
    
}
