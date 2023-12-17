//
//  RealmFoodPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import Foundation
import RealmSwift

class RealmFoodNutritionPresenter: Object {
  @Persisted dynamic var name: String
  @Persisted dynamic var calories: Double
  @Persisted dynamic var serving_size_g: Double
  @Persisted dynamic var fat_total_g: Double
  @Persisted dynamic var fat_saturated_g: Double
  @Persisted dynamic var protein_g: Double
  @Persisted dynamic var sodium_mg: Double
  @Persisted dynamic var potassium_mg: Double
  @Persisted dynamic var cholesterol_mg: Double
  @Persisted dynamic var carbohydrates_total_g: Double
  @Persisted dynamic var fiber_g: Double
  @Persisted dynamic var sugar_g: Double
}
