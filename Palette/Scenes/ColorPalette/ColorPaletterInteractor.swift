//
//  ColorPaletterInteractor.swift
//  Palette
//
//  Created by Saoirse on 9/30/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- Color Palette Interactor.
class ColorPaletterInteractor {
    private let webServiceInterface: WebServiceInterface
    private let authToken: String
    private let requestId: Int
    
    init(requestId: Int,
         authToken: String,
         webServiceInterface: WebServiceInterface) {
        self.requestId = requestId
        self.webServiceInterface = webServiceInterface
        self.authToken = authToken
    }
}

// MARK:- Color Palette Business Logic
extension ColorPaletterInteractor: ColorPaletterBusinessLogic {
    
    func fetchBackgroundColor() {
        let serviceRequest = ColorPaletteServiceRequest.fetchBackgroundColor(requestId: requestId,
                                                                             authToken: authToken)
        webServiceInterface.performService(serviceRequest: serviceRequest) { (result) in
            switch result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let serviceResponse = try jsonDecoder.decode(PaletteColorResponse.self, from: data)
                    // Set Available Color.
                    print(serviceResponse)
                }
                catch(let error){
                    // TODO: Set Background Color as White.
                    print(error.localizedDescription)
                }
                return
            case .failure(let error):
                // TODO: Set Background Color as White.
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    public func saveBackgroundColor(_ paletteColor: PaletteColor) {
        let serviceRequest = ColorPaletteServiceRequest.saveBackgroundColor(requestId: requestId,
                                                                            selectedColor: paletteColor,
                                                                            authToken: authToken)
        self.webServiceInterface.performService(serviceRequest: serviceRequest) { (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let serviceResponse = try jsonDecoder.decode(PaletteColorResponse.self, from: data)
                    // Set Available Color.
                    print(serviceResponse)
                }
                catch(let error){
                    // TODO: Set Background Color as White.
                    print(error.localizedDescription)
                }
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
