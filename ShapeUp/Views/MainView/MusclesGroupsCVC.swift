//
//  MusclesGroupsCVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 22.10.2023.
//

import UIKit

class MusclesGroupsCVC: UICollectionViewCell {
    var musclesDataArrayInCVC: (UIImage, String, Int)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupLayout() {
        contentView.backgroundColor = secondaryColor
        contentView.layer.cornerRadius = customCornerRadius
        
        if let musclesDataArrayInCVC = musclesDataArrayInCVC {
            
            let cellImage = UIImageView(image: musclesDataArrayInCVC.0)
            cellImage.contentMode = .scaleAspectFit
            contentView.addSubview(cellImage)
            
            cellImage.snp.makeConstraints {
                $0.top.equalToSuperview().inset(4)
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview().inset(70)
            }
            
            let exerciseTypeLabel = UILabel()
            exerciseTypeLabel.text = musclesDataArrayInCVC.1
            exerciseTypeLabel.textColor = customTextColor
            exerciseTypeLabel.font = .systemFont(ofSize: 17, weight: .bold)
            contentView.addSubview(exerciseTypeLabel)
            
            exerciseTypeLabel.snp.makeConstraints {
                $0.top.equalTo(cellImage.snp.bottom)
                $0.leading.equalToSuperview().inset(4)
            }
            
            let exerciseNumLabel = UILabel()
            exerciseNumLabel.text = "\(musclesDataArrayInCVC.2.description) Exercises"
            exerciseNumLabel.textColor = .lightGray
            exerciseNumLabel.font = .systemFont(ofSize: 17, weight: .bold)
            contentView.addSubview(exerciseNumLabel)
            
            exerciseNumLabel.snp.makeConstraints {
                $0.top.equalTo(exerciseTypeLabel.snp.bottom)
                $0.leading.equalToSuperview().inset(4)
            }
            
            
        }
    }
}
