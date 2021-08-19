//
//  SavedHeadline.swift
//  MVVMMedibankTest
//
//  Created by Jonathan Castillo on 18/8/21.
//

import Foundation


// MARK: - Welcome
struct SavedHeadlines: Decodable {
    let ScannedCount: Int
    let Count: Int
    let Items: [SavedHeadlineData]
  }
// MARK: - Datum
struct SavedHeadlineData: Decodable {
    let id: String?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let sourceName: String?

    
    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case sourceName = "sourceName"
       
    }
}
