//
//  PromoBanner.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit
import RealmSwift

struct PromoBanner: Codable, Hashable {
    
    var id: UUID
    var imageUrl: ImageUrl
    
}

//class PromoBannerRealm: EmbeddedObject {
//    
//    @Persisted var id: String = ""
//    @Persisted var imageBundleUrl: String = ""
//    
//}
