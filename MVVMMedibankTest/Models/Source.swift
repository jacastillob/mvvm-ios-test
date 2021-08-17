//
//  Source.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//

import Foundation

// MARK: - Welcome
struct Sources: Decodable {
    let status: String
    let sources: [SourceData]
  }
// MARK: - Datum
struct SourceData: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case description = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case country = "country"
    }
}
