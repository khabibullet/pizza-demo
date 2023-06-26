//
//  ProfileView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IProfileView: AnyObject {
    
}

class ProfileView: UIViewController, IProfileView {

    //MARK: - Private properties
    
    private let presenter: IProfilePresenter
    
    //MARK: - Lifecycle
    
    init(presenter: IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Профиль"
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
