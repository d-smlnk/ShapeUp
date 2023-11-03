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
        view.backgroundColor = DesignColorTemplates.mainColor
        
        let addProgramBtn = UIButton()
        addProgramBtn.setTitle("Add a program", for: .normal)
        addProgramBtn.backgroundColor = DesignColorTemplates.secondaryColor
        addProgramBtn.layer.cornerRadius = SizeOFElements.customCornerRadius
        addProgramBtn.setTitleColor(DesignColorTemplates.customTextColor, for: .normal)
        addProgramBtn.titleLabel?.font = .systemFont(ofSize: Fonts.separateTextFontSize, weight: .heavy)
        
        view.addSubview(addProgramBtn)
        
        addProgramBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }
    }

}
