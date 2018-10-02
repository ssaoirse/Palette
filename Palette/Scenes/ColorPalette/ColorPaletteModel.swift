//
//  ColorPaletteModel.swift
//  Palette
//
//  Created by Saoirse on 9/30/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation


// MARK:- Palette Color Service Response.
public struct PaletteColorResponse: Decodable {
    let id: String
    let paletteColor: PaletteColor
    private enum CodingKeys: String, CodingKey {
        case id             = "id"
        case paletteColor   = "data"
    }
}

// MARK:- Palette Color.
public struct PaletteColor: Decodable {
    let id: Int
    let hexString: String
    private enum CodingKeys: String, CodingKey {
        case id         = "id"
        case hexString  = "hexString"
    }
    
    // Helper function.
    public func toDictionary() -> JSONDictionary {
        return (["id": self.id, "hexString": self.hexString])
    }
}

