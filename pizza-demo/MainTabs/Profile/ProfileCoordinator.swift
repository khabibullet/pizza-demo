//
//  ProfileCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IProfileCoordinator: INavigationCoordinator {
    
}

class ProfileCoordinator: IProfileCoordinator {
    
    //MARK: - Public properties
    
    var navigationController: UINavigationController
    var didFinishClosure: (() -> ())?
    
    var profilePresenter: IProfilePresenter?
    
    //MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = ProfilePresenter()
        presenter.onOut = { (_) in }
        self.profilePresenter = presenter

        let view = ProfileView(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
}
