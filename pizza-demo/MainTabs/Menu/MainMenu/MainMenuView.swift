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
    
    private var menu: Menu!
    private var menuCategories: [CategoryState]!
    private var menuImages = Dictionary<UUID, UIImage>()

    private var promoBannerCellRegistration: UICollectionView
        .CellRegistration<PromoBannerCell, PromoBanner>!
    
    private var menuItemCellRegistration: UICollectionView
        .CellRegistration<MenuItemCell, MenuItem>!
    
    private var categoriesViewRegistration: UICollectionView
        .SupplementaryRegistration<CategoriesView>!
    
    private var categoriesViewPath: IndexPath?
    
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
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
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
        config.interSectionSpacing = 19
        layout.configuration = config
        
        let collectionView = UICollectionView.init(
            frame: .zero, collectionViewLayout: layout
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .Background.view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: cityPicker.bottomAnchor, constant: 19
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
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(300),
                        heightDimension: .absolute(112)
                    ),
                    subitem: item, count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            } else {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(200)
                    ),
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 1
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(56)
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
    
    // MARK: - Public methods
    
    @MainActor
    func show(menu: Menu) async {
        cityLabel.text = menu.city
        cityPicker.isHidden = false
        
        menuCategories = menu.items.map { CategoryState(id: $0.id, title: $0.title) }
        if !menuCategories.isEmpty {
            menuCategories[0].isSelected = true
        }
        setupCollectionViewElementsRegistration()
        reloadData(with: menu)
    }
    
    // MARK: - Private methods
    
    private func setupCollectionViewElementsRegistration() {
        
        categoriesViewRegistration = UICollectionView
            .SupplementaryRegistration<CategoriesView>(
                elementKind: "categories-view"
            ) { supplementaryView, _, indexPath in
                supplementaryView.categories = self.menuCategories
                supplementaryView.onSelect = { [weak self] id in
                    self?.categorySelected(uuid: id)
                }
                if self.categoriesViewPath == nil {
                    self.categoriesViewPath = indexPath
                }
            }
        
        promoBannerCellRegistration = UICollectionView
            .CellRegistration<PromoBannerCell, PromoBanner> { cell, _, promoBanner in
                cell.promoBanner = promoBanner
                if let image = self.menuImages[promoBanner.id] {
                    cell.image = image
                    return
                }
                Task {
                    let image = await MenuProvider.getImage(
                        uuid: promoBanner.id, url: promoBanner.imageUrl
                    )
                    cell.image = image
                    self.menuImages[promoBanner.id] = image
                }
            }
        
        menuItemCellRegistration = UICollectionView
            .CellRegistration<MenuItemCell, MenuItem> { cell, indexPath, menuItem in
                cell.menuItem = menuItem
                cell.isCellOnTop = indexPath.item == 0 ? true : false
                if let image = self.menuImages[menuItem.id] {
                    cell.image = image
                    return
                }
                Task {
                    let image = await MenuProvider.getImage(
                        uuid: menuItem.id, url: menuItem.imageUrl
                    )
                    cell.image = image
                    self.menuImages[menuItem.id] = image
                }
            }
        
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
        menuCollectionView.scrollToItem(at: path, at: .centeredVertically, animated: true)
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
