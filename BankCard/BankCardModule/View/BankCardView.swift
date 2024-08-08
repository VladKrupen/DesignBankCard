//
//  BankCardView.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

final class BankCardView: UIView {
    
    //MARK: - Dependecies
    private let manager = BankCardViewManager()
    
    
    //MARK: - Property
    private var cardColor: [String] = ["#16A085FF", "#003F32FF"] {
        willSet {
            if let colorView = viewWithTag(TagView.cardView) {
                colorView.layer.sublayers?.remove(at: 0)
                let gradient = manager.getGradient(colors: newValue)
                colorView.layer.insertSublayer(gradient, at: 0)
            }
        }
    }
    
    private var cardIcon: UIImage = .icon1 {
        willSet {
            if let imageView = cardView.viewWithTag(TagView.imageView) as? UIImageView {
                imageView.image = newValue
            }
        }
    }
    
    var selectedIndex: Int = 0
    
    private var balance: Float = 9.999
    private var cardNumber: Int = 1234
    
    //MARK: - UI
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cardView: UIView!
    private var colorCollection: UICollectionView!
    private var iconCollection: UICollectionView!
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#6F6F6FFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBankCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createBankCardView() {
        backgroundColor = UIColor(hex: "#141414FF")
        createScrollView()
        createPageTitle(title: "Design your virtual card")
        createCardView()
        createColorCollection(titleText: "Select color")
        createIconCollection(titleText: "Add shapes")
        createDescriptionLabel(text: "Don't worry. You can always change the design of your virtual card later. Just enter the settings.")
        createContinueButton()
    }
    
    private func createScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func createPageTitle(title: String) {
        pageTitle.text = title
        
        scrollView.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            pageTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10)
        ])
    }
    
    private func createCardView() {
        cardView = manager.getCardView(colors: cardColor, balance: balance, cardNumber: cardNumber, cardImage: cardIcon)
        scrollView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        ])
    }
    
    private func createColorCollection(titleText: String) {
        let colorCollectionTitle = manager.collectionTitle(titleText: titleText)
        colorCollection = manager.getCollection(id: RestoreIDs.colors, dataSource: self, delegate: self)
        colorCollection.register(ColorCell.self, forCellWithReuseIdentifier: String(describing: ColorCell.self))
        
        scrollView.addSubview(colorCollectionTitle)
        scrollView.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
            colorCollectionTitle.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50),
            colorCollectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            colorCollectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: colorCollectionTitle.bottomAnchor, constant: 20),
            colorCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorCollection.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createIconCollection(titleText: String) {
        let iconCollectionTitle = manager.collectionTitle(titleText: titleText)
        
        iconCollection = manager.getCollection(id: RestoreIDs.icons, dataSource: self, delegate: self)
        iconCollection.register(IconCell.self, forCellWithReuseIdentifier: String(describing: IconCell.self))
        
        scrollView.addSubview(iconCollectionTitle)
        scrollView.addSubview(iconCollection)
        
        NSLayoutConstraint.activate([
            iconCollectionTitle.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 40),
            iconCollectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            iconCollectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            iconCollection.topAnchor.constraint(equalTo: iconCollectionTitle.bottomAnchor, constant: 20),
            iconCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconCollection.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createDescriptionLabel(text: String) {
        descriptionLabel.text = text
        descriptionLabel.setLineHeight(lineHeight: 10)
        scrollView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: iconCollection.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
    
    private func createContinueButton() {
        scrollView.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension BankCardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors:
            return manager.colors.count
        case RestoreIDs.icons:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCell.self), for: indexPath) as? ColorCell else {
                return UICollectionViewCell()
            }
            let color = manager.colors[indexPath.item]
            cell.setCell(colors: color)
            
            if indexPath.item == selectedIndex {
                cell.selectItem()
            } else {
                cell.deselectItem()
            }
            return cell
        case RestoreIDs.icons:
            guard let cell = iconCollection.dequeueReusableCell(withReuseIdentifier: String(describing: IconCell.self), for: indexPath) as? IconCell else {
                return UICollectionViewCell()
            }
            let icon = manager.images[indexPath.item]
            cell.setIcon(icon: icon)
        
            if indexPath.item == selectedIndex {
                cell.selectItem()
            } else {
                cell.deselectItem()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension BankCardView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors:
            selectedIndex = indexPath.item
            collectionView.reloadData()
            
            let colors = manager.colors[indexPath.item]
            self.cardColor = colors
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
        case RestoreIDs.icons:
            selectedIndex = indexPath.item
            collectionView.reloadData()
            
            let image = manager.images[indexPath.item]
            self.cardIcon = image
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors:
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.deselectItem()
        case RestoreIDs.icons:
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
    }
}

//MARK: - OBJC
extension BankCardView {
    @objc private func continueButtonTapped() {
        print(1)
    }
}

