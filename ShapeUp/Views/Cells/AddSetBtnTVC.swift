//
//  AddSetBtnTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 25.11.2023.
//

import UIKit

class AddSetBtnTVC: UITableViewCell {
    
    static let reuseIdentifier = "AddSetBtnTVC"
    
    let addSetBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.mainColor
        
        addSetBtn.setTitle("Add Set", for: .normal)
        addSetBtn.backgroundColor = DS.DesignColorTemplates.borderColor
        addSetBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        contentView.addSubview(addSetBtn)
        
        //MARK: CONSTRAINTS

        addSetBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
    }
}

