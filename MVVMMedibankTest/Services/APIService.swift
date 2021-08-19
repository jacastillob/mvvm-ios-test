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
    
    func putHeadline(newHeadline: HeadlineData){
        
        guard let url = URL(string: "https://7eva400bz6.execute-api.ap-southeast-2.amazonaws.com/savedhealines") else {
                    print("Error: cannot create URL")
                    return
                }
        // Create model
        struct UploadData: Codable {
            let id: String
            let sourceName: String
            let author: String
            let title: String
            let description: String
            let url: String
            let urlToImage: String
        }
 
        
        let uploadDataModel = UploadData(id: UUID().uuidString,
                                         sourceName: newHeadline.source.name ?? "",
                                         author:newHeadline.author ?? "",
                                         title:newHeadline.title ?? "",
                                         description:newHeadline.description ?? "",
                                         url:newHeadline.url ?? "",
                                         urlToImage:newHeadline.urlToImage ?? "")
   
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
     
       var request = URLRequest(url: url)
                request.httpMethod = "PUT"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling PUT")
                        print(error!)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                   
                }.resume()
        
        
    }
    
    func deleteSavedHeadline(id : String ) {
        
        
            let url = URL(string: "https://7eva400bz6.execute-api.ap-southeast-2.amazonaws.com/savedhealines/"+id)!
         
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling DELETE")
                    print(error!)
                    return
                }
              
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
               
            }.resume()
        }
    
    
}
