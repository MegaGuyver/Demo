//
//  MainViewControllerService.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import Foundation

protocol MainViewControllerServiceProtocol {
    func fetchMostPopular(completion: @escaping (Result<MostPopular, Error>) -> Void)
}

class MainViewControllerService: MainViewControllerServiceProtocol {
    
    func fetchMostPopular(completion: @escaping (Result<MostPopular, Error>) -> Void) {
        
        NetworkManager.shared.executeRequest(url: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?api-key=tvUa8FeJqYKZlxvSTUwdx7y4JnjsZmUC") { (result: Result<MostPopular,Error>) in
            switch result{
            case .success(let popular):
                completion(.success(popular))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
