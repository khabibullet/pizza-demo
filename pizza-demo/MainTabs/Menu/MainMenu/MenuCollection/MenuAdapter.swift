//
//  MenuAdapter.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import Foundation

enum MenuCollectionSectionType: Hashable {
    case bannersSection
    case menuCategorySection
}

enum MenuCollectionItem: Hashable {
    case promoBanner(PromoBanner)
    case menuItem(MenuItem)
}

enum MenuCollectionCell {
    case promoBanner(PromoBanner)
    case menuItem(MenuItem)
}
