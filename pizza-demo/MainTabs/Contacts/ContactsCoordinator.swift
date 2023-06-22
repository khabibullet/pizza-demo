//
//  ContactsCoordinator.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IContactsCoordinator: INavigationCoordinator {
    
}

class ContactsCoordinator: IContactsCoordinator {
    
    //MARK: - Public properties
    
    var navigationController: UINavigationController
    var didFinishClosure: (() -> ())?
    
    var contactsPresenter: IContactsPresenter?
    
    //MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = ContactsPresenter()
        presenter.onOut = { (_) in }
        self.contactsPresenter = presenter

        let view = ContactsView(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
}
