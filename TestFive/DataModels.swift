//
//  DataModels.swift
//  TestFive
//
//  Created by Dr.Alexandr on 26.12.2022.
//

import Foundation

struct TestDataDTO: Decodable {
    let data: [PopulationInfo]
}

struct PopulationInfo: Codable {
    let iDNation: String
    let nation: String
    let iDYear: Int
    let year: String
    let population: Int
    let slugNation: String

    private enum CodingKeys: String, CodingKey {
        case iDNation = "ID Nation"
        case nation = "Nation"
        case iDYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
