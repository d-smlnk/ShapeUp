//
//  File.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.11.2023.
//

import Foundation
import UIKit

func presentedIndicator(_ vc: UIViewController) -> UIView {
    let indicatorView = UIView()
    let indicatorViewHeight = 4
    indicatorView.layer.cornerRadius = CGFloat(indicatorViewHeight / 2)
    indicatorView.backgroundColor = .lightGray
    vc.view.addSubview(indicatorView)
    
    indicatorView.snp.makeConstraints {
        $0.top.equalToSuperview().inset(Paddings.spacing)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(vc.view.frame.size.width / 7)
        $0.height.equalTo(indicatorViewHeight)
    }
    return indicatorView
}
