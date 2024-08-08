//
//  IconCell.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

final class IconCell: UICollectionViewCell {
    
    private lazy var checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    func setIcon(icon: UIImage) {
        imageView.image = icon
        self.addSubview(imageView)
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            
            checkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func selectItem() {
        checkImage.isHidden = false
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
}
