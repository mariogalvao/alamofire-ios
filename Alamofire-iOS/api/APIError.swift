//
//  APIError.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import Foundation

class APIError: Error {
    
    var code: Int
    var message: String
    var detail: String
    
    init(code: Int, message: String, detail: String) {
        self.code = code
        self.message = message
        self.detail = detail
    }

}
