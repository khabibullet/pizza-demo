//
//  MenuCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IMenuCoordinator: INavigationCoordinator {
    
}

class MenuCoordinator: IMenuCoordinator {
    
    //MARK: - Public properties
    
    var navigationController: UINavigationController
    var didFinishClosure: (() -> ())?
    
    var mainMenuPresenter: IMainMenuPresenter?
    
    //MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = MainMenuPresenter()
        presenter.onOut = { (_) in }
        self.mainMenuPresenter = presenter

        let view = MainMenuView(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
}
