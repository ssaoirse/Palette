//
//  LoginResponseModel.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

struct ServiceResponse: Decodable {
    let response: JSONDictionary
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        response = try container.decode(JSONDictionary.self)
    }
}


/// Login Response Model
struct LoginResponseModel: Decodable {
    let token: String
    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
