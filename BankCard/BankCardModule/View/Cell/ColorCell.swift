//
//  ColorCell.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
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
    
    func setCell(colors: [String]) {
        let gradient = BankCardViewManager().getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
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
