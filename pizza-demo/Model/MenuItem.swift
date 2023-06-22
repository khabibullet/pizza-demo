//
//  MenuItem.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit
import RealmSwift

struct MenuItem: Codable {
    
    var id: UUID
    var title: String
    var text: String
    var price: String
    var imageRemoteUrl: String
    
}

class MenuItemRealm: EmbeddedObject {
    
    @Persisted var itemTitle: String = ""
    @Persisted var text: String = ""
    @Persisted var price: String = ""
    @Persisted var imageBundleUrl: String = ""
    
}
