//
//  AddExerciseToRealm.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import Foundation
import RealmSwift
//#warning("Turn on realm")
public let realm = try! Realm()
let objects = realm.objects(RealmExerciseService.self)


    func addExerciseToRealm() {
        do {
            let settings = RealmExerciseService()
            try realm.write {
                settings.exerciseName = CreateExerciseVC.exerciseNameTF.text ?? "No exercise name"
                settings.muscleGroupOfExercise = ChooseMuscleForNewExerciseVC.muscleGroupNameDelegate ?? "No muscles group"
                realm.add(settings)
            }
            
        } catch {}
        print(objects)
    }

