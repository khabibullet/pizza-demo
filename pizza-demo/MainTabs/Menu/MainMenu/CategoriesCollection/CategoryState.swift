//
//  CategoryState.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 25.06.2023.
//

import UIKit

struct CategoryState: Hashable {
    
    var id: UUID
    var title: String
    var isSelected: Bool
    
    init(id: UUID, title: String, isSelected: Bool = false) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }
    
}
