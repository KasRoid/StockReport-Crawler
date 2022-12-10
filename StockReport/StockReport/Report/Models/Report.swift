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
        
        case buy = "Buy"
        case neutral = "Neutral"
        
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
