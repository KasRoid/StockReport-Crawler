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

extension ReportViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let report = viewModel.reports.value[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = report.title
        configuration.secondaryText = report.stock
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reports.value.count
    }
}

extension ReportViewController {
    
    private func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func bindVM() {
        viewModel.reports
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
    }
}
