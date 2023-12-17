//
//  QueryModel.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 08.12.2023.
//

import Foundation

struct QueryModel: Decodable {
    let status: String
    let data: [NutritionModel]
}
