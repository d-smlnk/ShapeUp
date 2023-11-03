//
//  ViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit

class ExercisePageVC: UIViewController {
    
    private let musclesDataArray = [
    (UIImage(named: "Neck") ?? UIImage(), "Neck", 8),
    (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest", 18),
    (UIImage(named: "BackMuscle") ?? UIImage(), "Back", 13),
    (UIImage(named: "LegMuscle") ?? UIImage(), "Legs", 10),
    (UIImage(named: "ShouldersMuscle") ?? UIImage(), "Shoulders", 14),
    (UIImage(named: "HandsMuscles") ?? UIImage(), "Biceps", 16),
    (UIImage(named: "TricepsMuscle") ?? UIImage(), "Triceps", 15),
    (UIImage(named: "Forearm") ?? UIImage(), "Forearm", 6),
    (UIImage(named: "PrelumMuscle") ?? UIImage(), "Core", 5),
    (UIImage(named: "CalvesMuscle") ?? UIImage(), "Calves", 3),
    (UIImage(named: "Cardio") ?? UIImage(), "Cardio", 3),
    (UIImage(named: "Yoga") ?? UIImage(), "Yoga", 20),
    (UIImage(named: "Crossfit") ?? UIImage(), "Crossfit", 30),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
        
        let createExerciseBtn = UIButton()
        createExerciseBtn.setTitle("Create an exercise", for: .normal)
        createExerciseBtn.backgroundColor = DesignColorTemplates.secondaryColor
        createExerciseBtn.layer.cornerRadius = SizeOFElements.customCornerRadius
        createExerciseBtn.setTitleColor(DesignColorTemplates.customTextColor, for: .normal)
        createExerciseBtn.titleLabel?.font = .systemFont(ofSize: Fonts.separateTextFontSize, weight: .heavy)
        createExerciseBtn.addTarget(self, action: #selector(goToMuscleGroupMenu), for: .touchUpInside)
        
        view.addSubview(createExerciseBtn)
        
        createExerciseBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }

        let muscleGroupTV = UITableView(frame: .zero, style: .grouped)
        muscleGroupTV.backgroundColor = .clear
        muscleGroupTV.separatorStyle = .none
        
        muscleGroupTV.dataSource = self
        muscleGroupTV.delegate = self
        
        muscleGroupTV.register(ExercisePageTVC.self, forCellReuseIdentifier: "ExerciseTVC")
        
        view.addSubview(muscleGroupTV)
        
        muscleGroupTV.snp.makeConstraints {
            $0.top.equalTo(createExerciseBtn.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func goToMuscleGroupMenu() {
        let vc = ChooseMuscleForExistedExerciseVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension ExercisePageVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return musclesDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTVC", for: indexPath) as? ExercisePageTVC
        cell?.musclesGroup = musclesDataArray[indexPath.section]
        cell?.configure()
        return cell ?? UITableViewCell()
    }
}
