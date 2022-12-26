//
//  ModelViewController.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation

protocol TestViewModelProtocol {
    var finishedDataParsing: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    func fetchTestData()
    func getDataForIndexPath(indexPath: IndexPath) -> PopulationInfo?
}


final class TestViewModel: TestViewModelProtocol {
    
    private var networkManager: NetworkManagerProtocol
    private var countries: [PopulationInfo]?
    var finishedDataParsing: (() -> Void)?
    var numberOfCells: Int {
        return countries?.count ?? 0
    }
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchTestData() {
        guard let url = URL(string: Constants.testUrl) else {return}
        networkManager.getData(url: url) { [unowned self] (result: Result<TestDataDTO,Error>) in
            switch result {
            case .success(let response):
                self.countries = response.data
                self.finishedDataParsing?()
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
    
    func getDataForIndexPath(indexPath: IndexPath) -> PopulationInfo? {
        return countries?[indexPath.row]
    }
}

// MARK: - Constants Enum
fileprivate enum Constants {
    static let testUrl = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
}
