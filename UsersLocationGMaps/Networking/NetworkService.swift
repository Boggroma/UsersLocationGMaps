//
//  NetworkService.swift
//  UsersLocationGMaps
//
//  Created by мак on 19.09.2020.
//  Copyright © 2020 viktorsafonov. All rights reserved.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<[ClientData], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error", error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                do {
                    let clients = try JSONDecoder().decode([ClientData].self, from: data)
                    completion(.success(clients))
                } catch let jsonError {
                    print("Failed to decode", jsonError)
                    completion(.failure(jsonError))
                }
                    
//                let someString = String(data: data, encoding: .utf8)
//                print(someString ?? "no data")
            }
        }.resume()
    }
}


