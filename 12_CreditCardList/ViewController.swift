//
//  ViewController.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/13.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class ViewController: UIViewController {

    var ref : DatabaseReference! // 파이어베이스 레퍼런스(데이터베이스의 루트)
    
    lazy var mainTableView : UITableView =  {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(CreditCardListCell.self, forCellReuseIdentifier: "CreditCardListCell")
        return table
    }()
    
    var creditCardList : [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseSet()
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
    
    func databaseSet(){
        self.ref = Database.database().reference()
        ref.observe(.value){ snapshot in
            guard let value = snapshot.value as? [String : [String:Any]] else {return}
           
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String:CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted{
                    $0.rank < $1.rank
                }
                
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }catch{
                print("Error JSON : \(error)")
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.creditCardList.count
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
        detailV.DetailData = self.creditCardList[indexPath.row].promotionDetail
        self.navigationController?.pushViewController(detailV, animated: true)
    }
}
