//
//  ContactsView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IContactsView: AnyObject {
    
}

class ContactsView: UIViewController, IContactsView {

    //MARK: - Private properties
    
    private let presenter: IContactsPresenter
    
    //MARK: - Lifecycle
    
    init(presenter: IContactsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Контакты"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        presenter.view = self
    }
    
}
