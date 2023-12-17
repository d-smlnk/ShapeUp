//
//  MusclesGroupsCVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 22.10.2023.
//

import UIKit

class MusclesGroupsCVC: UICollectionViewCell {
    
    static let reuseIdentifier = "MusclesGroupsCVC"
    
    var musclesDataArrayInCVC: (UIImage, String, Int)?
    private let cellImage = UIImageView()
    private let exerciseTypeLabel = UILabel()
    private let exerciseNumLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        if let musclesDataArrayInCVC = musclesDataArrayInCVC {
            cellImage.image = musclesDataArrayInCVC.0
            exerciseTypeLabel.text = musclesDataArrayInCVC.1
            exerciseNumLabel.text = "\(musclesDataArrayInCVC.2.description) Exercises"
        }
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
                
        cellImage.contentMode = .scaleAspectFit
        contentView.addSubview(cellImage)
        
        exerciseTypeLabel.textColor = DS.DesignColorTemplates.customTextColor
        exerciseTypeLabel.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .bold)
        contentView.addSubview(exerciseTypeLabel)
        
        exerciseNumLabel.textColor = .lightGray
        exerciseNumLabel.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .bold)
        contentView.addSubview(exerciseNumLabel)
        
        //MARK: CONSTRAINTS
        
        cellImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(70)
        }
        
        exerciseTypeLabel.snp.makeConstraints {
            $0.top.equalTo(cellImage.snp.bottom)
            $0.leading.equalToSuperview().inset(4)
        }
        
        exerciseNumLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseTypeLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(4)
        }
    }
}
