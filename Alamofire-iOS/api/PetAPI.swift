//
//  PetAPI.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import Foundation
import Alamofire

protocol PetAPIProtocol {
    
    func getPets(by status: Pet.Status, completion: @escaping (Result<[Pet], APIError>) -> Void)
    
}

class PetAPI: API, PetAPIProtocol {
    
    func getPets(by status: Pet.Status, completion: @escaping (Result<[Pet], APIError>) -> Void) {
                
        let path = "\(API.basePath)/pet/findByStatus"
        var components = URLComponents(string: path)!
        components.queryItems = [URLQueryItem(name: "status", value: status.rawValue)]
        
        AF.request(try! components.asURL(),
                   method: .get,
                   encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                if let error = response.error {
                    let apiError = APIError(code: error.responseCode ?? 999, message: error.localizedDescription, detail: response.error.debugDescription)
                    completion(.failure(apiError))
                    return
                }
                
                guard let data = response.data else {
                    let apiError = APIError(code: 999, message: "Empty data", detail: "")
                    completion(.failure(apiError))
                    return
                }
                
                do {
                    let pets = try JSONDecoder().decode([Pet].self, from: data)
                    completion(.success(pets))
                } catch let error {
                    let apiError = APIError(code: 999, message: "Decoding error", detail: error.localizedDescription)
                    completion(.failure(apiError))
                }
            })
        
    }

}
