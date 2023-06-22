//
//  AppCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit
 
protocol IAppCoordinator: IWindowCoordinator {
    
}

class AppCoordinator: IAppCoordinator {
    
    // MARK: - Public Properties
    
    var window: UIWindow
    var didFinishClosure: (() -> ())?
    
    // MARK: - Private Properties
    
    private var mainTabsCoordinator: ITabCoordinator
    
    // MARK: - Public Methods
    
    func start() {
        window.rootViewController = mainTabsCoordinator.tabBarController
        window.makeKeyAndVisible()
        
        mainTabsCoordinator.start()
    }
    
    // MARK: - Lifecycle
    
    init(window: UIWindow) {
        self.window = window
        
        let tabBarController = UITabBarController()
        mainTabsCoordinator = MainTabsCoordinator(tabBarController: tabBarController)
    }
    
}
