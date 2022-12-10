//
//  ReportTableViewCell.swift
//  StockReport
//
//  Created by Doyoung Song on 12/9/22.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    static let identifier = String(describing: ReportTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: PaddingLabel!
    @IBOutlet weak var opinionColorView: UIView!
    @IBOutlet weak var securitiesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(report: Report) {
        titleLabel.text = report.title
        stockLabel.text = report.stock
        opinionColorView.backgroundColor = report.opinion.color
        securitiesLabel.text = report.securites
        dateLabel.text = report.date
    }
}

// MARK: - UI
extension ReportTableViewCell {
    
    private func setupUI() {
        selectionStyle = .none
        stockLabel.layer.cornerRadius = 4
        opinionColorView.layer.cornerRadius = 4
        stockLabel.clipsToBounds = true
        opinionColorView.clipsToBounds = true
    }
}
