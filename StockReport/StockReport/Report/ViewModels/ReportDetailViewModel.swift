//
//  ReportDetailViewModel.swift
//  StockReport
//
//  Created by Doyoung Song on 12/10/22.
//

import UIKit

struct ReportDetailViewModel {
    
    private let report: Report
    
    var stock: String {
        return report.stock
    }
    
    var securities: String {
        return report.securites
    }
    
    var title: String {
        return report.title
    }
    
    var opinion: String {
        return report.opinion.rawValue
    }
    
    var opinionColr: UIColor {
        return report.opinion.color
    }
    
    var date: String {
        return report.date + ","
    }
    
    var author: String {
        return report.author
    }
    
    init(report: Report) {
        self.report = report
    }
}
