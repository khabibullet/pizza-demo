//
//  CategoriesView.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import UIKit

class CategoriesView: UICollectionReusableView {
    
    private let categoryCellRegistration = UICollectionView
        .CellRegistration<CategoryCell, CategoryState> { cell, _, category in
            cell.state = category
    }

    private lazy var categoriesCollection: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: {_,_ in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(88),
                        heightDimension: .absolute(32)
                    )
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: item.layoutSize,
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                return section
            }
        )
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        backgroundColor = .Background.view
        collectionView.backgroundColor = .Background.view
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -24
            )
        ])
        return collectionView
    }()

    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, CategoryState>(
        collectionView: categoriesCollection,
        cellProvider: { (collectionView, indexPath, categoryState) in
            return collectionView.dequeueConfiguredReusableCell(
                using: self.categoryCellRegistration,
                for: indexPath,
                item: categoryState
            )
        }
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var onSelect: ((UUID) -> Void)?

    var categories: [CategoryState]? {
        didSet {
            guard let categories else { return }
            reloadData(with: categories)
            categoriesCollection.isHidden = false
        }
    }

    private func reloadData(with categories: [CategoryState]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryState>()

        snapshot.appendSections([0])
        snapshot.appendItems(categories, toSection: 0)

        dataSource.apply(snapshot)
    }

    func categorySelected(index: Int) {
        let path = IndexPath(item: index, section: 0)

        for (id, _) in categories!.enumerated() {
            categories![id].isSelected = id == index
        }
        categoriesCollection.scrollToItem(
            at: path, at: .left, animated: true
        )
    }
    
}

extension CategoriesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        categorySelected(index: indexPath.item)
        onSelect?(item.id)
    }
    
}
