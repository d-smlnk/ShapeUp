//
//  ExerciseContentTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit
import RealmSwift

class ExercisePageTVC: UITableViewCell {
    
    static let reuseIdentifier = "ExercisePageTVC"
    
    var musclesGroup: (UIImage, String, Int)?
    private let muscleImage = UIImageView()
    private let muscleGroupLabel = UILabel()
    private let exerciseAdded = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        muscleImage.image = musclesGroup?.0
        muscleGroupLabel.text = musclesGroup?.1
        if let exerciseAddedText = musclesGroup?.2 {
            exerciseAdded.text = "\(exerciseAddedText) Exercise(s)"
        }
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        contentView.superview?.clipsToBounds = true
        contentView.superview?.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        selectionStyle = .none

        muscleImage.contentMode = .scaleAspectFit
        contentView.addSubview(muscleImage)
        
        muscleGroupLabel.text = musclesGroup?.1
        muscleGroupLabel.font = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .heavy)
        muscleGroupLabel.textColor = DS.DesignColorTemplates.customTextColor
        contentView.addSubview(muscleGroupLabel)
        
        exerciseAdded.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .bold)
        exerciseAdded.textColor = .gray
        contentView.addSubview(exerciseAdded)
        
        let goNextBtn = UIButton()
        goNextBtn.setImage(UIImage(named: "GoNext"), for: .normal)
        contentView.addSubview(goNextBtn)
        
        //MARK: CONSTRAINTS
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.edges.equalToSuperview()
        }
        
        muscleImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(DS.Paddings.padding)
            $0.width.equalTo(40)
        }
        
        muscleGroupLabel.snp.makeConstraints {
            $0.top.equalTo(muscleImage.snp.top).inset(DS.Paddings.padding)
            $0.leading.equalTo(muscleImage.snp.trailing).offset(DS.Paddings.spacing)
        }
        
        exerciseAdded.snp.makeConstraints {
            $0.top.equalTo(muscleGroupLabel.snp.bottom)
            $0.leading.equalTo(muscleImage.snp.trailing).offset(DS.Paddings.spacing)
        }
        
        goNextBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.width.equalTo(50)
        }
        
    }
}
