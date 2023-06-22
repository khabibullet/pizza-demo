//
//  BasketPresenter.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import Foundation

enum BasketPresenterOut {
    
}

protocol IBasketPresenter: AnyObject {
    var view: IBasketView? { get set }
    var onOut: ((BasketPresenterOut) -> ())? { get set }
}

class BasketPresenter: IBasketPresenter {
    
    //MARK: - Public properties
    
    var onOut: ((BasketPresenterOut) -> ())?
    
    weak var view: IBasketView? {
        didSet {
            fetchBasket()
        }
    }
    
    func fetchBasket() {
        
    }
    
}
