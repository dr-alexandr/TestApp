//
//  ViewController.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    private var viewModel: ViewModelViewControllerProtocol
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let loader = UIActivityIndicatorView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
        bind()
        loader.startAnimating()
        viewModel.takeData()
    }
    
    init(viewModel: ViewModelViewControllerProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(loader)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        loader.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(MyTableCell.self, forCellReuseIdentifier: "MyTableViewCell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    private func bind() {
        viewModel.onCompletion = { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        viewModel.takeData()
    }
    
    // MARK: - TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableCell
        cell.data = viewModel.getDataForIndexPath(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
// MARK: - Presentable 
extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}


