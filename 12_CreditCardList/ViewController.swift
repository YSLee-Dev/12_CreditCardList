//
//  ViewController.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/13.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    lazy var mainTableView : UITableView =  {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(CreditCardListCell.self, forCellReuseIdentifier: "CreditCardListCell")
        return table
    }()
    
    var creditCardList : [CreditCard] = [CreditCard(id: 1, rank: 1, name: "TEST", cardImageURL: "nil", promotionDetail: PromotionDetail(companyName: "TEST", period: "TEST", amount: 1, condition: "TEST", benefitCondition: "TEST", benefitDetail: "TEST", benefitDate: "TEST"), isSelected: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }

    func viewSet(){
        self.view.backgroundColor = self.mainTableView.backgroundColor
        self.title = "카드추천"
        
        self.view.addSubview(self.mainTableView)
        NSLayoutConstraint.activate([
            self.mainTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mainTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.mainTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.creditCardList.count
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardListCell", for: indexPath) as? CreditCardListCell else {return UITableViewCell()}
        
        cell.promotionLabel.text = "\(self.creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.rankLabel.text = "\(self.creditCardList[indexPath.row].rank)위"
        cell.cardNameLabel.text = self.creditCardList[indexPath.row].name
        
        let imgURL = URL(string: self.creditCardList[indexPath.row].cardImageURL)
        cell.cardImg.kf.setImage(with: imgURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailV = CardDetailViewController()
        self.navigationController?.pushViewController(detailV, animated: true)
    }
}
