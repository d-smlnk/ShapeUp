//
//  RealmWeightAndSet.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 14.11.2023.
//

import Foundation
import RealmSwift

class RealmWeightAndSet: Object {
    @Persisted dynamic var weight: String
    @Persisted dynamic var rep: String
}
