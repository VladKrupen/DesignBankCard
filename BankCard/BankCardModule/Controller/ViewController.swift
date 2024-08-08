//
//  ViewController.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let bankCardView = BankCardView()

    override func loadView() {
        super.loadView()
        view = bankCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

