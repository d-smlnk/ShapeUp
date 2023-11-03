//
//  CreateExerciseVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.11.2023.
//

import UIKit
import RealmSwift

class CreateExerciseVC: UIViewController {
    
    static let exerciseNameTF = UITextField()
    private let choosenMuscleGroupName = ChooseMuscleForNewExerciseVC.muscleGroupNameDelegate
    private let choosenMuscleGroupImage = ChooseMuscleForNewExerciseVC.muscleGroupImageDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.borderColor
        
        let categoryLabel = UILabel()
        categoryLabel.text = choosenMuscleGroupName
        categoryLabel.font = .systemFont(ofSize: Fonts.titleFontSize, weight: .bold)
        categoryLabel.textColor = DesignColorTemplates.secondaryColor
        categoryLabel.setContentHuggingPriority(.required, for: .horizontal)
        categoryLabel.setContentHuggingPriority(.required, for: .vertical)
        
        view.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(Paddings.padding)
        }
        
        CreateExerciseVC.exerciseNameTF.autocapitalizationType = .words
        customTextField(image: choosenMuscleGroupImage ?? UIImage(), placeholder: "Exercise name", contentType: .name, textField: CreateExerciseVC.exerciseNameTF)
        
        view.addSubview(CreateExerciseVC.exerciseNameTF)
        
        CreateExerciseVC.exerciseNameTF.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(Paddings.padding)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
        }
        
        let saveBtn = UIButton()
        saveBtn.setTitle("Create", for: .normal)
        saveBtn.layer.cornerRadius = SizeOFElements.customCornerRadius
        saveBtn.backgroundColor = DesignColorTemplates.customTextColor
        saveBtn.titleLabel?.font = .systemFont(ofSize: Fonts.separateTextFontSize, weight: .bold)
        saveBtn.addTarget(self, action: #selector(addExerciseToRealm1), for: .touchUpInside)
        
        view.addSubview(saveBtn)
        
        saveBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.width.equalTo(view.frame.width / 2)
        }
    }
    
    @objc private func addExerciseToRealm1() {
        addExerciseToRealm()
        dismiss(animated: true)
    }
}
