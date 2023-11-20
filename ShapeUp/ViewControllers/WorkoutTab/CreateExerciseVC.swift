//
//  CreateExerciseVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.11.2023.
//

import UIKit
import RealmSwift

class CreateExerciseVC: UIViewController {
    
    static let exerciseNameTF = UITextField(image: ChooseMuscleForNewExerciseVC.muscleGroupImageDelegate ?? UIImage(), placeholder: "Exercise name", contentType: .name)

    private let choosenMuscleGroupName = ChooseMuscleForNewExerciseVC.muscleGroupNameDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.borderColor
        
        let categoryLabel = UILabel()
        categoryLabel.text = choosenMuscleGroupName
        categoryLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .bold)
        categoryLabel.textColor = DS.DesignColorTemplates.secondaryColor
        categoryLabel.setContentHuggingPriority(.required, for: .horizontal)
        categoryLabel.setContentHuggingPriority(.required, for: .vertical)
        view.addSubview(categoryLabel)
 
        CreateExerciseVC.exerciseNameTF.autocapitalizationType = .words
        view.addSubview(CreateExerciseVC.exerciseNameTF)
 
        let saveBtn = UIButton()
        saveBtn.setTitle("Create", for: .normal)
        saveBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        saveBtn.backgroundColor = DS.DesignColorTemplates.customTextColor
        saveBtn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .bold)
        saveBtn.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
        view.addSubview(saveBtn)
        
        //MARK: CONSTRAINTS
        
        categoryLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        
        CreateExerciseVC.exerciseNameTF.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(DS.Paddings.padding)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        saveBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.width.equalTo(view.frame.width / 2)
        }
    }
    
    @objc private func addExercise() {
        RealmPresenter.addExerciseToRealm()
        dismiss(animated: true)
    }
}
