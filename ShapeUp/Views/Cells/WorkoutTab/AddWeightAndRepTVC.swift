//
//  AddSetAndRepTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit

class AddWeightAndRepTVC: UITableViewCell {
    
    static let reuseIdentifier = "AddWeightAndRepTVC"
    var weightAndSetData: RealmPickedExercisePresenter?
    static let weightTF = UITextField(image: UIImage(named: "scale") ?? UIImage(), placeholder: "Weight", contentType: .numberPad)
    static let repTF = UITextField(image: UIImage(named: "reps") ?? UIImage(), placeholder: "Rep", contentType: .numberPad)
    private let setAndRepSV = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.borderColor
        selectionStyle = .none

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
            setAndRepSV.addArrangedSubview($0)
        }
    }
    
}
