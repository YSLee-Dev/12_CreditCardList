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
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    var promotionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.backgroundColor = .gray
        return label
    }()
    
    var cardNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
            self.mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        self.mainStackView.addArrangedSubview(self.cardImg)
        self.mainStackView.addArrangedSubview(self.textStackView)
        self.mainStackView.addArrangedSubview(self.detailArrow)
        NSLayoutConstraint.activate([
            self.cardImg.widthAnchor.constraint(equalToConstant: 40),
            self.cardImg.heightAnchor.constraint(equalToConstant: 30),
            self.detailArrow.widthAnchor.constraint(equalToConstant: 15),
            self.detailArrow.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        self.textStackView.addArrangedSubview(self.detailStackView)
        self.textStackView.addArrangedSubview(self.cardNameLabel)
        
        self.detailStackView.addArrangedSubview(self.rankLabel)
        self.detailStackView.addArrangedSubview(self.promotionLabel)
        
    }
    
}
