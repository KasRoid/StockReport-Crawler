//
//  CSVReader.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Foundation

struct CSVReader {
    
    static func read(file: String) -> [[String]] {
        let csvPath = Bundle.main.path(forResource: file, ofType: "csv")
        guard let csvPath else { return [] }

        do {
            let csvData = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)

            var parsedCSV = csvData
                .components(separatedBy: "\n")
                .map{
                    let list = $0
                        .components(separatedBy: ",")
                        .map { String($0.filter { !"\n\t\r".contains($0) }) }
                    return list
                }

            let sectionCount = parsedCSV.first?.count
            parsedCSV.removeFirst()
            return parsedCSV.filter { $0.count == sectionCount }
        } catch{
            print(error)
            return []
        }
    }
}
