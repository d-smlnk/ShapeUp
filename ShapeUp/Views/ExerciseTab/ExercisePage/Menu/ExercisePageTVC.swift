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
        contentView.backgroundColor = DesignColorTemplates.secondaryColor
        contentView.layer.cornerRadius = SizeOFElements.customCornerRadius
        contentView.superview?.clipsToBounds = true
        contentView.superview?.layer.cornerRadius = SizeOFElements.customCornerRadius
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.edges.equalToSuperview()
        }
        
        muscleImage.contentMode = .scaleAspectFit
        
        contentView.addSubview(muscleImage)
        
        muscleImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Paddings.padding)
            $0.width.equalTo(40)
        }
        
        muscleGroupLabel.text = musclesGroup?.1
        muscleGroupLabel.font = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .heavy)
        muscleGroupLabel.textColor = DesignColorTemplates.customTextColor
        
        contentView.addSubview(muscleGroupLabel)
        
        muscleGroupLabel.snp.makeConstraints {
            $0.top.equalTo(muscleImage.snp.top).inset(Paddings.padding)
            $0.leading.equalTo(muscleImage.snp.trailing).offset(Paddings.spacing)
        }
        
        exerciseAdded.font = .systemFont(ofSize: Fonts.simpleTextFontSize, weight: .bold)
        exerciseAdded.textColor = .gray
        
        contentView.addSubview(exerciseAdded)
        
        exerciseAdded.snp.makeConstraints {
            $0.top.equalTo(muscleGroupLabel.snp.bottom)
            $0.leading.equalTo(muscleImage.snp.trailing).offset(Paddings.spacing)
        }
        
        let goNextBtn = UIButton()
        goNextBtn.setImage(UIImage(named: "GoNext"), for: .normal)
        
        contentView.addSubview(goNextBtn)
        
        goNextBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Paddings.padding)
            $0.height.width.equalTo(50)
        }
        
    }
}
