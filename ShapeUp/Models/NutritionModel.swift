//
//  NutritionModel.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import Foundation

struct NutritionModel: Decodable {
    let name: String
    let calories: Double
    let serving_size_g: Double
    let fat_total_g: Double
    let fat_saturated_g: Double
    let protein_g: Double
    let sodium_mg: Double
    let potassium_mg: Double
    let cholesterol_mg: Double
    let carbohydrates_total_g: Double
    let fiber_g: Double
    let sugar_g: Double
}
