//
//  Report.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Foundation

struct Report: Hashable {
    
    let date: String
    let stock: String
    let ticker: String
    let title: String
    let fairValue: String
    let opinion: String
    let author: String
    let securites: String
}
