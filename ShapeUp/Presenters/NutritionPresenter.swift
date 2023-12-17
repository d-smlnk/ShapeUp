//
//  NutritionPresenter.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import Foundation
import Alamofire

final class NutritionPresenter {
    
    init() {}
    
    static let shared = NutritionPresenter()
    
    weak var queryDelegate: SendQueryDelegate?
    
    func fetchMeals(completion: @escaping(Result<[NutritionModel], Error>) -> Void) {
        print("start fetching")
        let header: HTTPHeaders = ["X-Api-Key" : "DmwCoBxXqvLayAUCTWHVNg==ifBhTAlH7XM9JhcL"]
            
        guard let query = queryDelegate?.queryDelegate?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        AF.request("\(ApiPresenter.Link.nutrition.url)" + query, headers: header)
            .validate()
            .responseDecodable(of: [NutritionModel].self) { response in
                print("Status code: \(String(describing: response.response?.statusCode))")
                
                if response.error != nil {
                    print("Error: \(String(describing: response.error))")
                } else {
                    guard let decodedNutrition = response.value else { return }
                    completion(.success(decodedNutrition))
                    
                    guard let error = response.error else { return }
                    completion(.failure(ApiPresenter.ErrorData.message(error)))
                }
            }
    }
}
