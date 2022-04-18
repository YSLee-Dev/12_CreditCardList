//
//  ViewController.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/13.
//

import UIKit

class ViewController: UIViewController {

    lazy var mainTableView : UITableView =  {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CreditCardListCell.self, forCellReuseIdentifier: "CreditCardListCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }

    func viewSet(){
        self.view.addSubview(self.mainTableView)
        NSLayoutConstraint.activate([
            self.mainTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardListCell", for: indexPath) as! CreditCardListCell
        cell.promotionLabel.text = "-만원 혜택"
        cell.rankLabel.text = "-위"
        cell.cardNameLabel.text = "신용카드"
        return cell
    }
    
    
}
