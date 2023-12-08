//
//  RealmPickedExerciseService.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 06.11.2023.
//

import Foundation
import RealmSwift

class RealmPickedExercisePresenter: Object {
    @Persisted dynamic var exerciseName: String
    @Persisted dynamic var muscleGroupOfExercise: String
    @Persisted dynamic var exerciseDate: Date
    @Persisted dynamic var weightAndRep: List<RealmWeightAndSetPresenter>
}
