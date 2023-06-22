//
//  PromoBanner.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit
import RealmSwift

struct PromoBanner: Codable {
    
    var id: UUID
    var imageRemoteUrl: String
    
}

class PromoBannerRealm: EmbeddedObject {
    
    @Persisted var imageBundleUrl: String = ""
    
}
