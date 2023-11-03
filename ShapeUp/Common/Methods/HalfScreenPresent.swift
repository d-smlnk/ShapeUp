//
//  HalfScreenPresent.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import Foundation
import UIKit

func halfScreenPresent(_ selfVC: UIViewController, presentedVC: UIViewController) {
    
    if let presentationController = presentedVC.presentationController as? UISheetPresentationController {
        presentationController.detents = [.medium()]
    }
    selfVC.present(presentedVC, animated: true)
}

