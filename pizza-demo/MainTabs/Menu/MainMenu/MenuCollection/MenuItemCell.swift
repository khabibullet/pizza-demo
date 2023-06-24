//
//  MenuItemCell.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, descriptionStack])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 15
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16
            ),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20
            ),
            stack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -20
            )
        ])
        contentView.backgroundColor = .Background.cell
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 130).isActive = true
        image.widthAnchor.constraint(equalToConstant: 130).isActive = true
        return image
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel, contentLabel, priceLabelStack]
        )
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Heading.bold
        label.textColor = .Text.title
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .Content.medium
        label.textColor = .Text.content
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var priceLabelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [UIView(), priceLabel])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Content.medium
        label.textColor = .Button.selected
        label.layer.borderColor = UIColor.Button.selected.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    var isCellOnTop: Bool = false
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var menuItem: MenuItem? {
        didSet {
            titleLabel.text = menuItem?.title
            contentLabel.text = menuItem?.text
            priceLabel.text = "от \(menuItem?.price ?? "0") р"
            horizontalStack.isHidden = false
        }
    }
    
    private func roundCorners(radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isCellOnTop = false
        menuItem = nil
        image = nil
        roundCorners(radius: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCellOnTop {
            roundCorners(radius: 20)
        }
    }
    
}
