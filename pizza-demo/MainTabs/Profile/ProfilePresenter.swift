//
//  ProfilePresenter.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

enum ProfilePresenterOut {
    
}

protocol IProfilePresenter: AnyObject {
    var view: IProfileView? { get set }
    var onOut: ((ProfilePresenterOut) -> ())? { get set }
}

class ProfilePresenter: IProfilePresenter {
    
    //MARK: - Public properties
    
    var onOut: ((ProfilePresenterOut) -> ())?
    
    weak var view: IProfileView? {
        didSet {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        
    }
    
}
