//
//  GitHubRepository.swift
//  APIModelTest
//
//  Created by Ryota Karita on 2022/02/18.
//

import Foundation

struct GitHubRepository: Codable, Equatable {
    let id: Int
    let star: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case star = "stargazers_count"
        case name
    }
}
