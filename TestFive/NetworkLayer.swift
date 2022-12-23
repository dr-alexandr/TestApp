//
//  NetworkLayer.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation
import Alamofire

struct Data : Codable {
    let iDNation : String?
    let nation : String?
    let iDYear : Int?
    let year : String?
    let population : Int?
    let slugNation : String?

    private enum CodingKeys: String, CodingKey {

        case iDNation = "ID Nation"
        case nation = "Nation"
        case iDYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iDNation = try values.decodeIfPresent(String.self, forKey: .iDNation)
        nation = try values.decodeIfPresent(String.self, forKey: .nation)
        iDYear = try values.decodeIfPresent(Int.self, forKey: .iDYear)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        slugNation = try values.decodeIfPresent(String.self, forKey: .slugNation)
    }

}

struct TestDataDTO: Decodable {
    let data: [Data]
}



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
                            let result = try! decoder.decode(T.self, from: jsonData)
                            DispatchQueue.main.async {
                                completion(.success(result))
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
