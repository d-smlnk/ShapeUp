//
//  AddSetAndRepTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit

class AddWeightAndRepTVC: UITableViewCell {
    
    static let reuseIdentifier = "AddSetAndRepTVC"
    
    private let setTF = UITextField()
    private let repTF = UITextField()
    private let setAndRepSV = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DesignColorTemplates.mainColor
        
        customTextField(image: UIImage(), placeholder: "Set", contentType: .creditCardNumber, textField: setTF)
        customTextField(image: UIImage(), placeholder: "Rep", contentType: .creditCardNumber, textField: repTF)
        
        setAndRepSV.axis = .horizontal
        setAndRepSV.distribution = .fillEqually
        setAndRepSV.spacing = CGFloat(Paddings.spacing)
        
        contentView.addSubview(setAndRepSV)
        
        setAndRepSV.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }
    }
    
        func configure() {            
            [setTF, repTF].forEach {
                $0.backgroundColor = .lightGray
                $0.layer.cornerRadius = SizeOFElements.customCornerRadius
                setAndRepSV.addArrangedSubview($0)
            }
            
        }
    
}
