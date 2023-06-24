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
    
    private var menuCategories: [CategoryState]!
    
    private var menu: Menu!
    
    //MARK: - Subviews
    
    private lazy var cityPicker: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, arrowButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.isHidden = true
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        return stack
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Heading.semibold
        label.textColor = .Text.title
        label.sizeToFit()
        return label
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.arrow, for: .normal)
        button.tintColor = .Text.title
        return button
    }()
    
    //MARK: - Menu Collection View
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = menuCollectionLayout
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        layout.configuration = config
        
        let collectionView = UICollectionView.init(
            frame: .zero, collectionViewLayout: layout
        )
        collectionView.backgroundColor = .Background.view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: cityPicker.bottomAnchor, constant: 15
            ),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
        return collectionView
    }()
    
    private lazy var menuCollectionLayout = UICollectionViewCompositionalLayout(sectionProvider: { id, _ in
            if id == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(300),
                        heightDimension: .absolute(112)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0, leading: 16, bottom: 0, trailing: 0
                )
                section.interGroupSpacing = 16
                return section
            } else {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(50)
                    )
                )
                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(50)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.interGroupSpacing = 1
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(30)
                    ),
                    elementKind: "categories-view",
                    alignment: .top
                )
                sectionHeader.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
    )
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<MenuCollectionSectionType, MenuCollectionItem> = {
        let dataSource = UICollectionViewDiffableDataSource<MenuCollectionSectionType, MenuCollectionItem>(
            collectionView: menuCollectionView,
            cellProvider: { (collectionView, indexPath, itemIdentifier) in
                switch itemIdentifier {
                case .promoBanner(let promoBanner):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: self.promoBannerCellRegistration,
                        for: indexPath,
                        item: promoBanner
                    )
                case .menuItem(let menuItem):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: self.menuItemCellRegistration,
                        for: indexPath,
                        item: menuItem
                    )
                }
            }
        )
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: self.categoriesViewRegistration,
                for: indexPath
            )
        }
        return dataSource
    }()
    
    private let promoBannerCellRegistration = UICollectionView
        .CellRegistration<PromoBannerCell, PromoBanner> { cell, _, promoBanner in
            cell.promoBanner = promoBanner
            Task {
                cell.image = await MenuProvider.shared.getImage(
                    uuid: promoBanner.id, url: promoBanner.imageUrl
                )
            }
    }
    
    private let menuItemCellRegistration = UICollectionView
        .CellRegistration<MenuItemCell, MenuItem> { cell, indexPath, menuItem in
            cell.menuItem = menuItem
            cell.isCellOnTop = indexPath.item == 0 ? true : false
            Task {
                cell.image = await MenuProvider.shared.getImage(
                    uuid: menuItem.id, url: menuItem.imageUrl
                )
            }
    }
    
    private var categoriesViewRegistration: UICollectionView
        .SupplementaryRegistration<CategoriesView>!
    
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
        view.backgroundColor = .Background.view
        
        presenter.view = self
    }
    
    private var categoriesViewPath: IndexPath?
    
    @MainActor
    func show(menu: Menu) async {
        cityLabel.text = menu.city
        cityPicker.isHidden = false
        
        menuCategories = menu.items.map { CategoryState(id: $0.id, title: $0.title) }
        if !menuCategories.isEmpty {
            menuCategories[0].isSelected = true
        }
        categoriesViewRegistration = UICollectionView
            .SupplementaryRegistration<CategoriesView>(elementKind: "categories-view") {
            supplementaryView, _, indexPath in
            supplementaryView.categories = self.menuCategories
            supplementaryView.onSelect = { [weak self] id in
                self?.categorySelected(uuid: id)
            }
            if self.categoriesViewPath == nil {
                self.categoriesViewPath = indexPath
            }
        }
        reloadData(with: menu)
    }
    
    private func reloadData(with menu: Menu) {
        self.menu = menu
        
        var snapshot = NSDiffableDataSourceSnapshot<MenuCollectionSectionType, MenuCollectionItem>()
        
        snapshot.appendSections([
            MenuCollectionSectionType.bannersSection,
            MenuCollectionSectionType.menuCategorySection
        ])
        snapshot.appendItems(
            menu.promoBanners.map({ MenuCollectionItem.promoBanner($0) }),
            toSection: MenuCollectionSectionType.bannersSection
        )
        for category in menu.items {
            snapshot.appendItems(
                category.items.map({ MenuCollectionItem.menuItem($0) }),
                toSection: MenuCollectionSectionType.menuCategorySection
            )
        }
        dataSource.apply(snapshot)
    }
    
    private func categorySelected(uuid: UUID) {
        guard
            let category = menu.items.first(where: { $0.id == uuid }),
            let item = category.items.first,
            let path = dataSource.indexPath(for: MenuCollectionItem.menuItem(item))
        else {
            return
        }
        menuCollectionView.scrollToItem(at: path, at: .top, animated: true)
    }
    
}

extension MainMenuView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard
            let topCell = menuCollectionView.visibleCells.first,
            let path = menuCollectionView.indexPath(for: topCell),
            let item = dataSource.itemIdentifier(for: path)
        else { return }
        var id: Int!
        switch item {
        case .promoBanner(_):
            id = 0
        case .menuItem(let item):
            id = menu.items.firstIndex(where: {
                $0.items.contains(where: { $0 == item })
            })
        }
        let categoriesView = menuCollectionView.supplementaryView(
            forElementKind: "categories-view", at: categoriesViewPath!
        ) as! CategoriesView
        categoriesView.categorySelected(index: id)
    }
    
}
