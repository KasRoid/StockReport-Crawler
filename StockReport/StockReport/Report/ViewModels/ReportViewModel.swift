//
//  ReportViewModel.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Combine
import Foundation

class ReportViewModel {
    
    let reports = CurrentValueSubject<[Report], Never>([])
    private var reportsSanpshot: [Report] = []
    
    init() {
        generateReports()
    }
}

extension ReportViewModel {
    
    func filterReports(text: String) {
        let filteredReports = reportsSanpshot.filter { $0.stock.contains(text) }
        self.reports.send(filteredReports)
    }
    
    func resetReports() {
        self.reports.send(reportsSanpshot)
    }
    
    private func generateReports() {
        let reportsData = CSVReader.read(file: "report_result")
        var reports = [Report]()
        
        reportsData.forEach {
            let date = $0[0]
            let stock = $0[1]
            let ticker = $0[2]
            let title = $0[3]
            let fairValue = $0[4]
            let opinion: Report.Opinion = $0[5] == "Buy" ? .buy : .neutral
            let author = $0[6]
            let securites = $0[7]
            let report = Report(date: date, stock: stock, ticker: ticker, title: title, fairValue: fairValue, opinion: opinion, author: author, securites: securites)
            if !reports.contains(report) {
                reports.append(report)
            }
        }
        self.reports.send(reports)
        reportsSanpshot = reports
    }
}
