//
//  NetworkManager.swift
//  ucheba app
//
//  Created by Марк Голубев on 05.02.2023.
//

import Foundation


protocol NetworkManagerDelegate {
    func didUpdateList(_ coinManager: NetworkManager, _ newList: [Institution])
    
    func didFailWithError(_ error: Error)
}

struct NetworkManager {
    //    static var shared = NetworkManager()
    let baseURL = "https://api.dev.ucheba.space/"
    var delegate: NetworkManagerDelegate?
    
    func getInstitutions() {
        let endpoint = baseURL + "v1/institutions"
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                delegate?.didFailWithError(error!)
                return }
            do {
                let jsonData = try JSONDecoder().decode(InstitutionsModel.self, from: data)
                guard let institutions = jsonData.items else { return }
                delegate?.didUpdateList(self, institutions)
                print("get inst")
            } catch let error {
                delegate?.didFailWithError(error)
            }
        }
        task.resume()
    }
    
}

