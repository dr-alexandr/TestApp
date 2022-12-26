//
//  ViewController.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import UIKit
import SnapKit

final class TestViewController: UIViewController, UITableViewDelegate {

    // MARK: - Properties
    private var viewModel: TestViewModelProtocol
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let loader = UIActivityIndicatorView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
    }
    
    init(viewModel: TestViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.rowHeight = Constants.tableCellRowHeight
        tableView.tableFooterView = UIView()
        tableView.register(MyTableCell.self, forCellReuseIdentifier: "MyTableViewCell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        bindDataReturn()
        loader.startAnimating()
        viewModel.fetchTestData()
    }
    
    private func bindDataReturn() {
        viewModel.finishedDataParsing = { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        viewModel.fetchTestData()
    }
}

// MARK: - Extension
extension TestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "MyTableViewCell",
                                     for: indexPath) as? MyTableCell else {
            return UITableViewCell()
        }
        cell.data = viewModel.getDataForIndexPath(indexPath: indexPath)
        return cell
    }
}

// MARK: - Constants Enum
fileprivate enum Constants {
    static let tableCellRowHeight: CGFloat = 100
}

