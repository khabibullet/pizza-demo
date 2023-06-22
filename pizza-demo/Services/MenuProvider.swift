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
    
    static let menuURL = URL(string: "")!
    
    private init() {}
    
    func fetchMenu() {
        
    }
    
}
