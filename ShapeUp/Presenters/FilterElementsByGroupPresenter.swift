//
//  FilterRealmElementPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 07.11.2023.
//

import Foundation
import RealmSwift

func filterElementsByGroup<T: Object>(realmDB: T.Type, filterBy key: String, for word: String) -> Results<T> {
    let result = realm.objects(realmDB).filter("\(key) == %@", word)
    return result
}
