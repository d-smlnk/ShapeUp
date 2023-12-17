//
//  RealmPickedFoodPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import Foundation
import RealmSwift

class RealmPickedFoodPresenter: Object {
    @Persisted dynamic var foodList: List<RealmFoodNutritionPresenter>
    @Persisted dynamic var name: String
    @Persisted dynamic var date: Date
    @Persisted dynamic var mealTime: String
}
