//
//  Tag.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import Foundation

class Tag: Codable {
    
    public var _id: Int64?
    public var name: String?

    public init(_id: Int64?, name: String?) {
        self._id = _id
        self.name = name
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case name
    }
    
}
