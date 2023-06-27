//
//  MenuItemCell.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    private var imageTopAnchorConstraint: NSLayoutConstraint?
    private var titleTopAnchorConstraint: NSLayoutConstraint?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        imageTopAnchorConstraint = image.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: isCellOnTop ? 24 : 16
        )
        NSLayoutConstraint.activate([
            imageTopAnchorConstraint!,
            image.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16
            ),
            image.heightAnchor.constraint(equalToConstant: 130),
            image.widthAnchor.constraint(equalToConstant: 130),
            image.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor, constant: -20
            )
        ])
        return image
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        return spinner
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Heading.bold
        label.textColor = .Text.title
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        titleTopAnchorConstraint = label.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: isCellOnTop ? 28 : 20
        )
        NSLayoutConstraint.activate([
            titleTopAnchorConstraint!,
            label.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor, constant: 16
            ),
            label.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20
            )
        ])
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .Content.medium
        label.textColor = .Text.content
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Content.medium
        label.textColor = .Button.selected
        label.layer.borderColor = UIColor.Button.selected.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 80),
            label.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
            label.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -20
            )
        ])
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .Background.cell
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCellOnTop: Bool = false
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            spinner.stopAnimating()
        }
    }
    
    var menuItem: MenuItem? {
        didSet {
            titleLabel.text = menuItem?.title
            contentLabel.text = menuItem?.text
            priceLabel.text = menuItem?.price
            
            imageTopAnchorConstraint?.constant = isCellOnTop ? 24 : 16
            titleTopAnchorConstraint?.constant = isCellOnTop ? 28 : 20
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
