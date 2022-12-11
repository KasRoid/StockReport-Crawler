//
//  ReportViewController.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Combine
import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ReportViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let reportDetailVC = segue.destination as? ReportDetailViewController,
              let indexPath = sender as? IndexPath else { fatalError() }
        
        let report = viewModel.reports.value[indexPath.row]
        let viewModel = ReportDetailViewModel(report: report)
        reportDetailVC.configure(viewModel: viewModel)
    }
}

// MARK: - UISearchBarDelegate
extension ReportViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ? viewModel.resetReports() : viewModel.filterReports(text: searchText)
    }
}

// MARK: - UITableViewDelegate
extension ReportViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = String(describing: ReportDetailViewController.self)
        performSegue(withIdentifier: identifier, sender: indexPath)
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UI
extension ReportViewController {
    
    private func setupUI() {
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.delegate = self
        
        let nib = UINib(nibName: ReportTableViewCell.identifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: ReportTableViewCell.identifier)
    }
    
    private func bindVM() {
        viewModel.reports
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
    }
}
