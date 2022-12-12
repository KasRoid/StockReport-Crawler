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
        let reportDatum = CSVReader.read(file: "report_result")
        var reports = [Report]()
        
        for (index, reportData) in reportDatum.enumerated() {
            guard index <= 200 else { break }
            let report = Report(reportData: reportData)
            
            if !reports.contains(report) {
                reports.append(report)
            }
        }
        
        self.reports.send(reports)
        reportsSanpshot = reports
        generateReportsInBackground(reportDatum: reportDatum)
    }
    
    private func generateReportsInBackground(reportDatum: [[String]]) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            var reports = [Report]()
            
            for index in 201 ..< reportDatum.count {
                let reportData = reportDatum[index]
                let report = Report(reportData: reportData)
                
                if !reports.contains(report) {
                    reports.append(report)
                }
                guard reports.count == 50 else { continue }
                self.reportsSanpshot += reports
                reports.removeAll()
            }
            self.reportsSanpshot += reports
            self.reports.send(self.reportsSanpshot)
        }
    }
}
