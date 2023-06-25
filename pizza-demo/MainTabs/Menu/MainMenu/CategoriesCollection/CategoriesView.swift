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
            print("cell provided")
    }

    private lazy var categoriesCollection: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: {_,_ in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(80),
                        heightDimension: .fractionalHeight(1.0)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                return section
            }
        )
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.backgroundColor = .yellow
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: topAnchor, constant: 20
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 16
            ),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -20
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
            print("categories set")
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
