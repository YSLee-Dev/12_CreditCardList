//
//  CreditCard.swift
//  12_CreditCardList
//
//  Created by 이윤수 on 2022/04/18.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let period: String
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String
    let companyName: String
    let amount: Int
}
