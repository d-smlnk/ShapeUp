//
//  StatCVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.12.2023.
//

import UIKit

class StatCVC: UICollectionViewCell {
    static let reuseIdentifier = "StatCVC"
    private let dateLabel = UILabel()
    private let setLabel = UILabel()

    var data: RealmPickedExerciseService?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.borderColor
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        
        dateLabel.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .bold)
        dateLabel.textColor = DS.DesignColorTemplates.secondaryColor
        contentView.addSubview(dateLabel)
        
        setLabel.numberOfLines = 0
        setLabel.setContentHuggingPriority(.required, for: .vertical)
        setLabel.textColor = DS.DesignColorTemplates.secondaryColor
        contentView.addSubview(setLabel)

        //MARK: - CONSTRAINTS
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        
        setLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
    }
    
    func configure() {
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle  = .long
            return formatter
        }()
        
        dateLabel.text = dateFormatter.string(from: data?.exerciseDate ?? Date())
        
        let setLabelText = data?.weightAndRep.enumerated().map ({ index, item in
            let line = "\(index + 1): \(item.weight) x \(item.rep)"
            return line
        }).joined(separator: "\n")
        
        setLabel.text = setLabelText
    
    }
}
