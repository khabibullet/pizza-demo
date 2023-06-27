//
//  MainTabsCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IMainTabsCoordinator: ITabCoordinator {
    
}

class MainTabsCoordinator: NSObject, IMainTabsCoordinator {
    
    // MARK: - Public properties
        
    var tabBarController: UITabBarController
    var didFinishClosure: (() -> ())?
    
    // MARK: - Private properties
    
    private var menuCoordinator: IMenuCoordinator
    private var contactsCoordinator: IContactsCoordinator
    private var profileCoordinator: IProfileCoordinator
    private var basketCoordinator: IBasketCoordinator
    
    
    // MARK: - Lifecycle
        
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        let menuNC = UINavigationController()
        menuNC.tabBarItem.image = Icon.food
        menuNC.navigationBar.isHidden = true
        self.menuCoordinator = MenuCoordinator(navigationController: menuNC)
        
        let contactsNC = UINavigationController()
        contactsNC.tabBarItem.image = Icon.location
        self.contactsCoordinator = ContactsCoordinator(navigationController: contactsNC)
        
        let profileNC = UINavigationController()
        profileNC.tabBarItem.image = Icon.profile
        self.profileCoordinator = ProfileCoordinator(navigationController: profileNC)
        
        let basketNC = UINavigationController()
        basketNC.tabBarItem.image = Icon.basket
        self.basketCoordinator = BasketCoordinator(navigationController: basketNC)
        
        super.init()
        
        tabBarController.delegate = self
        tabBarController.tabBar.tintColor = .TabBar.selected
        tabBarController.tabBar.unselectedItemTintColor = .TabBar.unselected
        tabBarController.tabBar.backgroundColor = .Background.cell
        
        let appearance = UITabBarAppearance()
        appearance.shadowColor = .Background.view
        appearance.backgroundColor = .Background.cell
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.standardAppearance = appearance
        
        tabBarController.tabBar.layer.shadowRadius = 10
        tabBarController.tabBar.layer.shadowColor = UIColor.Background.view.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 1.0
        
    }
    
    // MARK: - Public methods
    
    func start() {
        tabBarController.setViewControllers(
            [
                menuCoordinator.navigationController,
                contactsCoordinator.navigationController,
                profileCoordinator.navigationController,
                basketCoordinator.navigationController,
            ],
            animated: false
        )
        
        menuCoordinator.start()
        contactsCoordinator.start()
        profileCoordinator.start()
        basketCoordinator.start()
    }
    
}

extension MainTabsCoordinator: UITabBarControllerDelegate {
    
}
