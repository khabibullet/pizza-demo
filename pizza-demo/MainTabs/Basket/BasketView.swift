//
//  BasketView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IBasketView: AnyObject {
    
}

class BasketView: UIViewController, IBasketView {

    //MARK: - Private properties
    
    private let presenter: IBasketPresenter
    
    //MARK: - Lifecycle
    
    init(presenter: IBasketPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Корзина"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background.view
        
        presenter.view = self
    }
    
}
