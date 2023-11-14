//
//  ExerciseSetTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit
import RealmSwift

class ExerciseSetTVC: UITableViewCell {

    static let reuseIdentifier = "ExerciseSetTVC"
    
    private let weightTF = UITextField(image: UIImage(named: "scale") ?? UIImage(), placeholder: "Weight", contentType: .creditCardNumber)
    private let repTF = UITextField(image: UIImage(named: "reps") ?? UIImage(), placeholder: "Rep", contentType: .creditCardNumber)
    private let setAndRepSV = UIStackView()
    
    var exerciseName: String?
    
    var data: RealmWeightAndSet?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.mainColor
        
        setAndRepSV.axis = .horizontal
        setAndRepSV.distribution = .fillEqually
        setAndRepSV.spacing = CGFloat(DS.Paddings.spacing)
        contentView.addSubview(setAndRepSV)
  
        setAndRepSV.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
    }
    
    func configure() {
        [weightTF, repTF].forEach {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            setAndRepSV.addArrangedSubview($0)
        }
    
        weightTF.text = data?.weight
        repTF.text = data?.rep
    }
    
}
