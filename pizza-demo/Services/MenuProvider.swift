//
//  MenuProvider.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation
import RealmSwift

class MenuProvider {
    
    static let shared = MenuProvider()
    
    let realm = try! Realm()
    
    static let menuURL = URL(string: "https://raw.githubusercontent.com/khabibullet/pizza-demo/master/contents/pizza-demo-data.json")!
    
    private init() {}
    
    func fetchMenu() {
        
    }
    
}
