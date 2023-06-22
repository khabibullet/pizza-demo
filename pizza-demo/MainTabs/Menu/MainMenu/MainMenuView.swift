//
//  MainMenuView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IMainMenuView: AnyObject {
    
}

class MainMenuView: UIViewController, IMainMenuView {

    //MARK: - Private properties
    
    private let presenter: IMainMenuPresenter
    
    //MARK: - Lifecycle
    
    init(presenter: IMainMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Меню"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        presenter.view = self
    }
    
}
