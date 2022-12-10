//
//  ReportViewController.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Combine
import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ReportViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }
}

// MARK: - UITableViewDataSource
extension ReportViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier, for: indexPath) as? ReportTableViewCell else { fatalError() }
        let report = viewModel.reports.value[indexPath.row]
        cell.configure(report: report)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reports.value.count
    }
}

// MARK: - UI
extension ReportViewController {
    
    private func setupUI() {
        let nib = UINib(nibName: ReportTableViewCell.identifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: ReportTableViewCell.identifier)
    }
    
    private func bindVM() {
        viewModel.reports
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
    }
}
