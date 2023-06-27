//
//  PromoBannerCell.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 24.06.2023.
//

import UIKit

class PromoBannerCell: UICollectionViewCell {
    
    private lazy var bannerView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        return image
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        bannerView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor).isActive = true
        return spinner
    }()
    
    var promoBanner: PromoBanner?
    
    var image: UIImage? {
        didSet {
            bannerView.image = image
            spinner.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
        promoBanner = nil
    }
}
