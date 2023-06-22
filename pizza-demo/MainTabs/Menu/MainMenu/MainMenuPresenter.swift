//
//  MainMenuPresenter.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

enum MainMenuPresenterOut {
    
}

protocol IMainMenuPresenter: AnyObject {
    var view: IMainMenuView? { get set }
    var onOut: ((MainMenuPresenterOut) -> ())? { get set }
}

class MainMenuPresenter: IMainMenuPresenter {
    
    //MARK: - Public properties
    
    var onOut: ((MainMenuPresenterOut) -> ())?
    
    weak var view: IMainMenuView? {
        didSet {
            fetchMenu()
        }
    }
    
    func fetchMenu() {
        
    }
    
}
