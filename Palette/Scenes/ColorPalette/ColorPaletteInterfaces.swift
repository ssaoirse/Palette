//
//  ColorPaletteInterfaces.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// Interactor:
protocol ColorPaletterBusinessLogic {
    func fetchBackgroundColor()
    func saveBackgroundColor(_ paletteColor: PaletteColor)
}


