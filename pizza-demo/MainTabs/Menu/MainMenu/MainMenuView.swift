//
//  MainMenuView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 22.06.2023.
//

import UIKit

protocol IMainMenuView: AnyObject {
    
    func show(menu: Menu) async
    
}

class MainMenuView: UIViewController, IMainMenuView {

    //MARK: - Private properties
    
    private let presenter: IMainMenuPresenter
    
    
    //MARK: - Subviews
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return label
    }()
    
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
        
        statusLabel.isHidden = false
        presenter.view = self
    }
    
    @MainActor
    func show(menu: Menu) async {
        print(menu)
        
        statusLabel.text = String(menu.items.count)
    }
    
}
