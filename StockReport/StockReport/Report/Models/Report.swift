//
//  Report.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import UIKit

struct Report: Hashable {
    
    let date: String
    let stock: String
    let ticker: String
    let title: String
    let fairValue: String
    let opinion: Opinion
    let author: String
    let securites: String
    
    enum Opinion: String {
        
        case buy = "매수"
        case neutral = "중립"
        
        var color: UIColor {
            switch self {
            case .buy:
                return .systemGreen
            case .neutral:
                return .systemYellow
            }
        }
    }
}
