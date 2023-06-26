//
//  Color.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

extension UIColor {
    
    struct TabBar {
        
        static let selected = UIColor(named: "pink-100")!
        static let unselected = UIColor(named: "inactive")!
        static let background = UIColor(named: "background-2")!

    }
    
    struct Text {
        
        static let title = UIColor(named: "title")!
        static let content = UIColor(named: "content")!
        
    }
    
    struct Button {
        
        static let base = UIColor(named: "pink-40")!
        static let selected = UIColor(named: "pink-100")!
        static let background = UIColor(named: "pink-20")!
        
    }
    
    struct Background {
        
        static let view = UIColor(named: "background-1")!
        static let cell = UIColor(named: "background-2")!
        
    }
    
}

