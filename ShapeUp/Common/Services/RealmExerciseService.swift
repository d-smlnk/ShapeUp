//
//  RealmExerciseService.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import Foundation
import RealmSwift

class RealmExerciseService: Object {
    @Persisted(primaryKey: true) dynamic var exerciseName: String
    @Persisted dynamic var exerciseRep: Int
    @Persisted dynamic var exerciseSet: Int
    @Persisted dynamic var exerciseComent: String
}
