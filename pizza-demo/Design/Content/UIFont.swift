//
//  Font.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import UIKit

extension UIFont {
    
    struct Heading {

        static let semibold = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let bold = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    struct Content {
        
        static let medium = UIFont.systemFont(ofSize: 13, weight: .medium)
        
    }
    
    struct Button {
        
        static let medium = UIFont.systemFont(ofSize: 13, weight: .medium)
        static let bold = UIFont.systemFont(ofSize: 13, weight: .bold)
        
    }

}
