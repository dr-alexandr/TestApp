//
//  NetworkLayer.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url).validate().responseData { (data) in
                    switch data.result {
                    case .success(_):
                        let decoder = JSONDecoder()
                        if let jsonData = data.data {
                            do {
                                let result = try decoder.decode(T.self, from: jsonData)
                                DispatchQueue.main.async {
                                    completion(.success(result))
                                }
                            } catch {
                                completion(.failure(NetworkError.unableToDecode))
                            }
                        }
                        break
                    case .failure(_):
                        completion(.failure(NetworkError.noData))
                        break
                    }
                }
    }
}
