//
//  ProgramContentController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit

class ProgramPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    

    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        
        let addProgramBtn = UIButton()
        addProgramBtn.setTitle("Add a program", for: .normal)
        addProgramBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        addProgramBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        addProgramBtn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
        addProgramBtn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .heavy)
        
        view.addSubview(addProgramBtn)
        
        addProgramBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
    }

}
