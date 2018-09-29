//
//  LoginResponseModel.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// Login Response Model
struct LoginResponseModel: Decodable {
    let token: String
    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
