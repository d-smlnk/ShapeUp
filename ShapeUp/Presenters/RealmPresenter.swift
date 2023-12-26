//
//  FilterRealmElementPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 07.11.2023.
//

import Foundation
import RealmSwift

class RealmPresenter {
    
    static let realm = try! Realm()
    
    static func filterElementsByGroup<T: Object>(realmDB: T.Type, filterBy key: String, for word: String) -> Results<T> {
        let result = realm.objects(realmDB).filter("\(key) == %@", word)
        return result
    }
    
    static func numberOfFilteredElements<T: Object>(realmDB: T.Type, filterBy key: String, for word: String) -> Int {
        return filterElementsByGroup(realmDB: realmDB, filterBy: key, for: word).count
    }
    
    static func filterByDateAndExerciseName<T: Object>(realmDB: T.Type, exerciseName: String) -> Results<T> {
        let dateOnly = Calendar.current.startOfDay(for: WorkoutRoutineVC.choosenDate)
        
        let data = RealmPresenter.realm.objects(realmDB)
            .filter("exerciseDate >= %@", dateOnly)
            .filter("exerciseDate < %@", Calendar.current.date(byAdding: .day, value: 1, to: dateOnly) ?? Date())
            .filter("exerciseName == %@", exerciseName)
        
        return data
    } 
    
#warning("refactor this 2 method!")
    static func filterByDate_TimeAndMealName<T: Object>(realmDB: T.Type, mealTime: String) -> Results<T> {
        let dateOnly = Calendar.current.startOfDay(for: NutritionMainVC.choosenDate)
        
        let data = RealmPresenter.realm.objects(realmDB)
            .filter("date >= %@", dateOnly)
            .filter("date < %@", Calendar.current.date(byAdding: .day, value: 1, to: dateOnly) ?? Date())
            .filter("mealTime == %@", mealTime)
        
        return data
    }  
    
    static func filterByDateAndMealTime<T: Object>(realmDB: T.Type, mealTime: String) -> Results<T> {
        let dateOnly = Calendar.current.startOfDay(for: NutritionMainVC.choosenDate)
        
        let data = RealmPresenter.realm.objects(realmDB)
            .filter("date >= %@", dateOnly)
            .filter("date < %@", Calendar.current.date(byAdding: .day, value: 1, to: dateOnly) ?? Date())
            .filter("mealTime == %@", mealTime)
        
        return data
    }
    
    static func addExerciseToRealm() {
        let objects = realm.objects(RealmExercisePresenter.self)
        do {
            let settings = RealmExercisePresenter()
            try realm.write {
                settings.exerciseName = CreateExerciseVC.exerciseNameTF.text ?? "No exercise name"
                settings.muscleGroupOfExercise = ChooseMuscleForNewExerciseVC.muscleGroupNameDelegate ?? "No muscles group"
                realm.add(settings)
            }
            
        } catch {}
        print(objects)
    }
}
