//
//  RealmExerciseService.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import Foundation
import RealmSwift

class RealmExercisePresenter: Object {
    @Persisted(primaryKey: true) dynamic var exerciseName: String
    @Persisted dynamic var muscleGroupOfExercise: String
}
