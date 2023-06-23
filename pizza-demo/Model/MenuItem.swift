//
//  MenuItem.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit
import RealmSwift

enum ImageUrl: Codable, Hashable {
    case local(String)
    case remote(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let url = try container.decode(String.self)
        self = .remote(url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .local(let url), .remote(let url):
            try container.encode(url)
        }
    }
}

struct MenuItem: Codable, Hashable {
    
    var id: UUID
    var title: String
    var text: String
    var price: String
    var imageUrl: ImageUrl
    
}

//class MenuItemRealm: EmbeddedObject {
//    
//    @Persisted var id: String = ""
//    @Persisted var itemTitle: String = ""
//    @Persisted var text: String = ""
//    @Persisted var price: String = ""
//    @Persisted var imageBundleUrl: String = ""
//    
//}
