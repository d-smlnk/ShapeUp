//
//  HalfScreenPresent.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func halfScreenPresent(_ presentedVC: UIViewController) {
        if let presentationController = presentedVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }
        self.present(presentedVC, animated: true)
    }
}
