//
//  CreditCardListCell.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/18.
//

import UIKit

class CreditCardListCell: UITableViewCell {

    static let cellId = "CreditCardListCell"
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var textStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var detailStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var cardImg : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "creditcard")
        return img
    }()
    
    var rankLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-위"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    var promotionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-만원 혜택"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    var cardNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신용카드"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    var detailArrow : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "chevron.right")
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSet(){
        self.addSubview(self.mainStackView)
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
        
        self.mainStackView.addArrangedSubview(self.cardImg)
        self.mainStackView.addArrangedSubview(self.textStackView)
        self.mainStackView.addArrangedSubview(self.detailArrow)
        NSLayoutConstraint.activate([
            self.cardImg.widthAnchor.constraint(equalToConstant: 40),
            self.cardImg.heightAnchor.constraint(equalToConstant: 30),
            self.detailArrow.widthAnchor.constraint(equalToConstant: 20),
            self.detailArrow.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        self.textStackView.addArrangedSubview(self.detailStackView)
        self.textStackView.addArrangedSubview(self.cardNameLabel)
        
        self.detailStackView.addArrangedSubview(self.rankLabel)
        self.detailStackView.addArrangedSubview(self.promotionLabel)
        
    }
    
}
