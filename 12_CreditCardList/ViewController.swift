//
//  ViewController.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/13.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class ViewController: UIViewController {

    // var ref : DatabaseReference! // 파이어베이스 레퍼런스(데이터베이스의 루트)
    var db = Firestore.firestore()
    
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
        /* 파이어베이스 리얼타임
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
         */
        
        // 파이어베이스 파이어스토어
        self.db.collection("creditCardList").addSnapshotListener{ snapshot, error in
            guard let document = snapshot?.documents else{
                print("ERROR Document nil")
                return
            }
            
            self.creditCardList = document.compactMap{ doc -> CreditCard? in
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                }catch{
                    print(error)
                    return nil
                }
            }.sorted{
                $0.rank < $1.rank
            }
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
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
        self.mainTableView.deselectRow(at: indexPath, animated: true)
        let detailV = CardDetailViewController()
        detailV.detailData = self.creditCardList[indexPath.row].promotionDetail
        self.navigationController?.pushViewController(detailV, animated: true)
        
        /*
        // 옵션 1 == 경로를 알 때
        // let cardID = self.creditCardList[indexPath.row].id
        // ref.child("Item\(cardID)/isSelected").setValue(true)
        
        // 옵션 2 == 경로를 모를 때
        ref.queryOrdered(byChild: "id").queryEqual(toValue: self.creditCardList[indexPath.row].id).observe(.value){ [weak self] snapshot in
            guard let self = self, let value = snapshot.value as? [String : [String:Any]], let key = value.keys.first else {return}
            self.ref.child("\(key)/isSelected").setValue(true)
        }
         */
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            /*
            // 경로를 모르는 경우
            ref.queryOrdered(byChild: "id").queryEqual(toValue: self.creditCardList[indexPath.row].id).observe(.value){ [weak self] snapshot in
                guard let self = self, let value = snapshot.value as? [String:[String:Any]], let key = value.keys.first else {return}
                self.ref.child(key).removeValue()
            }
             */
        }
    }
}
