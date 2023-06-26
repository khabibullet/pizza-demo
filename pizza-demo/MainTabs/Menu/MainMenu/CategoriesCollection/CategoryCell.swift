//
//  CategoryCell.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 25.06.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20
            ),
            label.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20
            )
        ])
        return label
    }()
    
    var state: CategoryState? {
        didSet {
            label.text = state?.title
            if let selected = state?.isSelected, selected {
                setSelected()
            } else {
                setDeselected()
            }
        }
    }
    
    func setSelected() {
        label.font = .Button.bold
        label.textColor = .Button.selected
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = .none
        contentView.backgroundColor = .Button.base
    }
    
    func setDeselected() {
        label.font = .Button.medium
        label.textColor = .Button.base
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.Button.base.cgColor
        contentView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDeselected()
        state = nil
    }
    
}
