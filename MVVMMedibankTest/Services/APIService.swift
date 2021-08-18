//
//  APIService.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//

import Foundation

class APIService :  NSObject {
    
    private let apiKey = "6b92fe20c03b4f8d81991cd6818f915d"
    
    func getHeadlinesData(completion : @escaping (Headlines) -> ()){
        
        let sourcesURL = URL(string: "https://newsapi.org/v2/top-headlines?q=au&apiKey="+apiKey)!
        
        let task = URLSession.shared.dataTask(with: sourcesURL) { data, response, error in
            //print(String(data: data!, encoding: .utf8))
            if let payload = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode(Headlines.self, from: payload)
                completion(empData)
            }
        }
        task.resume()
        
    }
    func getSourcesData(completion : @escaping (Sources) -> ()){
        
        let sourcesURL = URL(string: "https://newsapi.org/v2/sources?language=en&apiKey="+apiKey)!
     
        let task = URLSession.shared.dataTask(with: sourcesURL) { data, response, error in
            //print(String(data: data!, encoding: .utf8))
            if let payload = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode(Sources.self, from: payload)
                completion(empData)
            }
        }
        task.resume()
    }
    
    func getSavedHeadlinesData(completion : @escaping (SavedHeadlines) -> ()){
        
        let sourcesURL = URL(string: "https://7eva400bz6.execute-api.ap-southeast-2.amazonaws.com/savedhealines")!
     
        let task = URLSession.shared.dataTask(with: sourcesURL) { data, response, error in
            //print(String(data: data!, encoding: .utf8))
            if let payload = data {
                let jsonDecoder = JSONDecoder()
                let savedHeadlinesData = try! jsonDecoder.decode(SavedHeadlines.self, from: payload)
                completion(savedHeadlinesData)
            }
        }
        task.resume()
    }
    
    
}
