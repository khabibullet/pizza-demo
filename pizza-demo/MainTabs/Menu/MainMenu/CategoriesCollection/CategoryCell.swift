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
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
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
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = .none
        contentView.backgroundColor = .Button.selected
        label.sizeToFit()
    }
    
    func setDeselected() {
        label.font = .Button.medium
        label.textColor = .Button.base
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.Button.base.cgColor
        contentView.backgroundColor = .clear
        label.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDeselected()
        state = nil
    }
    
}
