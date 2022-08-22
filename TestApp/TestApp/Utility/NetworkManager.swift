//
//  NetworkManager.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import Foundation

class NetworkManager {
    
    static func fetchUserList(onCompletion completion: @escaping ((Result<[HomeUser], Error>) -> Void)) {
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let users = try JSONDecoder().decode([HomeUser].self, from: data)
                        completion(.success(users))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(HTTPError.somethingWentWrong))
                }
            }
            task.resume()
        } else {
            completion(.failure(HTTPError.invalidURL))
        }
    }
}


enum HTTPError: Error {
    static let invalidURL = NSError(domain: "Invalid URL", code: 401, userInfo: nil)
    static let somethingWentWrong = NSError(domain: "Something went wrong", code: 402, userInfo: nil)
}
