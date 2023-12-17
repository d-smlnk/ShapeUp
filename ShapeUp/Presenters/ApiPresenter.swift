//
//  ApiPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 08.12.2023.
//

import Foundation

struct ApiPresenter {
    
    enum Link {
        case nutrition
        
        var url: URL {
            switch self {
            case .nutrition:
                return URL(string: "https://api.api-ninjas.com/v1/nutrition?query=") ?? URL(fileURLWithPath: "")
            }
        }
    }
    
    enum ErrorData: Error {
        case invalidData
        case InvalidResponse
        case message(_ error: Error)
    }
}
