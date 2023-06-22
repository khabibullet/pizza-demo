//
//  ContactsPresenter.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

enum ContactsPresenterOut {
    
}

protocol IContactsPresenter: AnyObject {
    var view: IContactsView? { get set }
    var onOut: ((ContactsPresenterOut) -> ())? { get set }
}

class ContactsPresenter: IContactsPresenter {
    
    //MARK: - Public properties
    
    var onOut: ((ContactsPresenterOut) -> ())?
    
    weak var view: IContactsView? {
        didSet {
            fetchContacts()
        }
    }
    
    func fetchContacts() {
        
    }
    
}
