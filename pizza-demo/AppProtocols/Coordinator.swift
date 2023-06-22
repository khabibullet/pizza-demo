//
//  Coordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol ICoordinator: AnyObject {
    func start()
    var didFinishClosure: (() -> ())? { get set }
}

protocol IWindowCoordinator: ICoordinator {
    var window: UIWindow { get set }
}

protocol INavigationCoordinator: ICoordinator {
    var navigationController: UINavigationController { get set }
}

protocol ITabCoordinator: ICoordinator {
    var tabBarController: UITabBarController { get set }
}
