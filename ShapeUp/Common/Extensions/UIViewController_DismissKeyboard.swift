//
//  UIViewController_DismissKeyboard.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 14.12.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
