//
//  BasketCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IBasketCoordinator: INavigationCoordinator {
    
}

class BasketCoordinator: IBasketCoordinator {
    
    //MARK: - Public properties
    
    var navigationController: UINavigationController
    var didFinishClosure: (() -> ())?
    
    var basketPresenter: IBasketPresenter?
    
    //MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = BasketPresenter()
        presenter.onOut = { (_) in }
        self.basketPresenter = presenter

        let view = BasketView(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
}
