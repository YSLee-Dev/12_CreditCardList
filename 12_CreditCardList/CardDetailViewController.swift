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
    var detailData : PromotionDetail?
    let list = DetailViewCellList()
    
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
    
    lazy var detailTableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCellId")
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .white
        return table
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
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.mainStackView.addArrangedSubview(self.imgView)
        self.mainStackView.addArrangedSubview(self.mTitle)
        self.mainStackView.addArrangedSubview(self.detailTableView)
        NSLayoutConstraint.activate([
            self.imgView.widthAnchor.constraint(equalTo: self.mainStackView.widthAnchor),
            self.imgView.heightAnchor.constraint(equalTo: self.imgView.widthAnchor, multiplier: 0.5),
            self.detailTableView.bottomAnchor.constraint(equalTo: self.mainStackView.bottomAnchor),
            self.detailTableView.widthAnchor.constraint(equalTo: self.mainStackView.widthAnchor)
        ])
        guard let detail = self.detailData else {return}
        self.mTitle.text = "\(detail.companyName)카드를 사용하시면\n\(detail.benefitDetail) 드려요."
    }
}

extension CardDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.list.Celllist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detail = self.detailData else {return UITableViewCell()}
        let detailList = [detail.period, detail.condition, detail.benefitCondition, detail.benefitDetail, detail.benefitDate]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCellId", for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        cell.Mtitle.text = "\(self.list.Celllist[indexPath.row]): "
        cell.detailLabel.text = detailList[indexPath.row]
        return cell
    }
    
}
