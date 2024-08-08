//
//  BankCardViewManager.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

class BankCardViewManager {
    
    let colors: [[String]] = [
        ["#16A085FF", "#003F32FF"],
        ["#9A00D1FF", "#45005DFF"],
        ["#FA6000FF", "#FAC6A6FF"],
        ["#DE0007FF", "#8A0004FF"],
        ["#2980B9FF", "#2771A1FF"],
        ["#E74C3CFF", "#93261BFF"]
    ]
    
    let images: [UIImage] = [.icon1, .icon2, .icon3, .icon4, .icon5, .icon6]
    
    func getGradient(frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 306, height: 175)), colors: [String]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map {
            UIColor(hex: $0)?.cgColor ?? UIColor.white.cgColor
        }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = [0, 1]
        return gradient
    }
    
    func getCardView(colors: [String], balance: Float, cardNumber: Int, cardImage: UIImage) -> UIView {
        let cardView: UIView = {
            let cardView = UIView()
            let gradient = getGradient(colors: colors)
            cardView.layer.insertSublayer(gradient, at: 0)
            cardView.clipsToBounds = true
            cardView.layer.cornerRadius = 30
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.widthAnchor.constraint(equalToConstant: 306).isActive = true
            cardView.heightAnchor.constraint(equalToConstant: 175).isActive = true
            cardView.tag = TagView.cardView
            return cardView
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = cardImage
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.opacity = 0.3
            imageView.tag = TagView.imageView
            return imageView
        }()
        
        let balanceLabel: UILabel = {
            let label = UILabel()
            label.text = "$\(balance)"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let numberLabel: UILabel = {
            let label = UILabel()
            label.text = "****\(cardNumber)"
            label.textColor = .white
            label.layer.opacity = 0.3
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(balanceLabel)
            stack.addArrangedSubview(numberLabel)
            return stack
        }()
        
        cardView.addSubview(imageView)
        cardView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
            
            hStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            hStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30),
            hStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30)
        ])
        return cardView
    }
    
    func collectionTitle(titleText: String) -> UILabel {
        let title: UILabel = {
            let title = UILabel()
            title.text = titleText
            title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            title.textColor = .white
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
        return title
    }
    
    func getCollection(id: String, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
        let collection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 62, height: 62)
            layout.minimumLineSpacing = 15
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.restorationIdentifier = id
            collection.delegate = delegate
            collection.dataSource = dataSource
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.heightAnchor.constraint(equalToConstant: 70).isActive = true
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            
            return collection
        }()
        return collection
    }

}
