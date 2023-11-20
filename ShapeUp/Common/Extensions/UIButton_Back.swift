//
//  UIButton_Back.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.11.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc private func back() {
        UIView.animate(withDuration: 1) {
            self.dismiss(animated: true)

        }
    }
    
    func backBtn() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints {
            $0.height.width.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        return btn
    }
}
