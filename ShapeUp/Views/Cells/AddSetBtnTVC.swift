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
    let copyTrainingBtn = UIButton()

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
        
        copyTrainingBtn.setImage(UIImage(named: "Copy"), for: .normal)
        copyTrainingBtn.imageView?.contentMode = .scaleAspectFit
        copyTrainingBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        copyTrainingBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        
        let btnSV = UIStackView(arrangedSubviews: [addSetBtn, copyTrainingBtn])
        btnSV.axis = .horizontal
        btnSV.spacing = CGFloat(DS.Paddings.spacing)
        contentView.addSubview(btnSV)
        
        
        //MARK: CONSTRAINTS

        btnSV.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        addSetBtn.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(contentView.frame.size.width / 1.5)
        }
        
        copyTrainingBtn.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(contentView.frame.size.width / 3)
        }

    }
}

