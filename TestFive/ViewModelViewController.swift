//
//  ModelViewController.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation

protocol ViewModelViewControllerProtocol {
    var onCompletion: (() -> Void)? { get set }
    var networkManager: NetworkManager { get set }
    var countries: [Data]? { get set }
    func takeData()
    func getCount() -> Int?
    func getDataForIndexPath(indexPath: IndexPath) -> Data?
}


final class ViewModelViewController: ViewModelViewControllerProtocol {
    
    var onCompletion: (() -> Void)?
    var networkManager = NetworkManager()
    var countries: [Data]?
    
    private let testUrl = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
    
    func takeData() {
        guard let url = URL(string: testUrl) else {return}
        networkManager.getData(url: url) { (result: Result<TestDataDTO,Error>) in
            switch result {
            case .success(let response):
                self.countries = response.data
                self.onCompletion?()
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
    
    func getDataForIndexPath(indexPath: IndexPath) -> Data? {
        return countries?[indexPath.row]
    }
    
    func getCount() -> Int? {
        return countries?.count
    }
    
}
