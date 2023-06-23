//
//  MenuItem.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

struct MenuItem: Codable, Hashable {
    
    var id: UUID
    var title: String
    var text: String
    var price: String
    var imageUrl: ImageUrl
    
}
