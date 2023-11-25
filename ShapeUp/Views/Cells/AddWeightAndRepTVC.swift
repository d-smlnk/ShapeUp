//
//  AddSetAndRepTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit

class AddWeightAndRepTVC: UITableViewCell {
    
    static let reuseIdentifier = "AddWeightAndRepTVC"
    var weightAndSetData: RealmPickedExerciseService?
    static let weightTF = UITextField(image: UIImage(named: "scale") ?? UIImage(), placeholder: "Weight", contentType: .creditCardNumber)
    static let repTF = UITextField(image: UIImage(named: "reps") ?? UIImage(), placeholder: "Rep", contentType: .creditCardNumber)
    private let setAndRepSV = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.secondaryColor
                
        setAndRepSV.axis = .horizontal
        setAndRepSV.distribution = .fillEqually
        setAndRepSV.spacing = CGFloat(DS.Paddings.spacing)
        contentView.addSubview(setAndRepSV)
        
        //MARK: CONSTRAINTS
        
        setAndRepSV.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
    }
    
    func configure() {
        [AddWeightAndRepTVC.weightTF, AddWeightAndRepTVC.repTF].forEach {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            setAndRepSV.addArrangedSubview($0)
        }
    }
    
}
