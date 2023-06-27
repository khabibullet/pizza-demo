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
    func fetchMenu()
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
        Task {
            try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            let menu = await MenuProvider.fetchMenu()
            await view?.show(menu: menu)
        }
    }
    
}
