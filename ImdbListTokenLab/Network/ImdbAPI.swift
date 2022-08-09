//
//  ImdbAPI.swift
//  ImdbList
//
//  Created by Danilo on 02/05/22.
//

import Alamofire
import Foundation

class ImdbAPI {
    let baseURL = Credentials.baseURL.rawValue
    
    func requestList(completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        AF.request(baseURL).responseDecodable(of: [Movie].self, queue: .main) { (response) in
            let result = response.result
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestDescription(movieID: String, completion: @escaping (Result<Description?, Error>) -> Void) {
        let url = "\(baseURL)/\(movieID)"
        AF.request(url).responseDecodable(of: Description.self, queue: .main) { (response) in
            let result = response.result
            switch result {
            case .success(let description):
                completion(.success(description))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

