//
//  ReportDetailViewController.swift
//  StockReport
//
//  Created by Doyoung Song on 12/10/22.
//

import Combine
import UIKit

class ReportDetailViewController: UIViewController {

    @IBOutlet weak var securitiesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var opinionLabel: PaddingLabel!
    @IBOutlet weak var tickerLabel: PaddingLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    @Published private var viewModel: ReportDetailViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    func configure(viewModel: ReportDetailViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UI
extension ReportDetailViewController {
    
    private func setupUI() {
        opinionLabel.layer.cornerRadius = 4
        tickerLabel.layer.cornerRadius = 4
        opinionLabel.clipsToBounds = true
        tickerLabel.clipsToBounds = true
    }
    
    private func bindUI() {
        $viewModel
            .sink { [weak self] viewModel in
                guard let self,
                      let viewModel = viewModel else { return }
                self.title = viewModel.stock
                self.securitiesLabel.text = viewModel.securities
                self.titleLabel.text = viewModel.title
                self.opinionLabel.text = viewModel.opinion
                self.opinionLabel.backgroundColor = viewModel.opinionColr
                self.tickerLabel.text = viewModel.ticker
                self.dateLabel.text = viewModel.date
                self.authorLabel.text = viewModel.author
            }
            .store(in: &cancellables)
    }
}
