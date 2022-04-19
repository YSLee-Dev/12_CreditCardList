//
//  CardDetailViewController.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/19.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {

    lazy var margin = self.navigationController?.systemMinimumLayoutMargins.leading
    
    var mTitle : UILabel = {
        let label = UILabel()
        label.text = "-카드를 사용하시면\n-만원을 드려요."
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        return stack
    }()
    
    var imgView : AnimationView = {
        let view = AnimationView(name: "money")
        view.loopMode = .loop
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.play()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    func viewSet(){
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.view.addSubview(self.mainStackView)
        guard let margin = self.margin else {return}
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin)
        ])
        
        self.mainStackView.addArrangedSubview(self.imgView)
        self.mainStackView.addArrangedSubview(self.mTitle)
        NSLayoutConstraint.activate([
            self.imgView.widthAnchor.constraint(equalTo: self.mainStackView.widthAnchor),
            self.imgView.heightAnchor.constraint(equalTo: self.imgView.widthAnchor, multiplier: 0.5)
        ])
    }
}
