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
    
    init(reportData: [String]) {
        date = reportData[0]
        stock = reportData[1]
        ticker = reportData[2]
        title = reportData[3]
        fairValue = reportData[4]
        opinion = Opinion(text: reportData[5])
        author = reportData[6]
        securites = reportData[7]
    }

    enum Opinion: String {
        
        case buy = "매수"
        case sell = "매도"
        case neutral = "중립"
        
        init(text: String) {
            switch text {
            case "Buy", "Outperform":
                self = .buy
            case "Reduce":
                self = .sell
            default:
                self = .neutral
            }
        }
        
        var color: UIColor {
            switch self {
            case .buy:
                return .systemGreen
            case .sell:
                return .systemRed
            case .neutral:
                return .systemYellow
            }
        }
    }
}
