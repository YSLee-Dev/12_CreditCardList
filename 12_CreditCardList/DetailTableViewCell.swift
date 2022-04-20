//
//  DetailTableViewCell.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static var DetailCellId = "DetailCellId"
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var Mtitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    var detailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
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
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        self.mainStackView.addArrangedSubview(self.Mtitle)
        self.mainStackView.addArrangedSubview(self.detailLabel)
        NSLayoutConstraint.activate([
            self.Mtitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.detailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
