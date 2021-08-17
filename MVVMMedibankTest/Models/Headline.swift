//
//  Headline.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//

import Foundation

// MARK: - Welcome
struct Headlines: Decodable {
    let status: String
    let totalResults: Int
    let articles: [HeadlineData]
  }
// MARK: - Datum
struct HeadlineData: Decodable {
    
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let source:HeadlineSourceData

    enum CodingKeys: String, CodingKey {
       
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case source = "source"
    }
}
// MARK: - Datum
struct HeadlineSourceData: Decodable {
    
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case name = "name"
    }
}


