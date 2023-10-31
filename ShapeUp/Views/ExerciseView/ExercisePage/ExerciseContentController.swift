//
//  ViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit

class ExerciseContentController: UIViewController {
    
    private let musclesDataArray = [
    (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest", 18),
    (UIImage(named: "BackMuscle") ?? UIImage(), "Back", 23),
    (UIImage(named: "LegMuscle") ?? UIImage(), "Legs", 12),
    (UIImage(named: "HandsMuscles") ?? UIImage(), "Hands",26)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
        
        let addExerciseBtn = UIButton()
        addExerciseBtn.setTitle("Add an exercise", for: .normal)
        addExerciseBtn.backgroundColor = DesignColorTemplates.secondaryColor
        addExerciseBtn.layer.cornerRadius = SizeOFElements.customCornerRadius
        addExerciseBtn.setTitleColor(DesignColorTemplates.customTextColor, for: .normal)
        addExerciseBtn.titleLabel?.font = .systemFont(ofSize: Fonts.fontSize, weight: .heavy)
        
        view.addSubview(addExerciseBtn)
        
        addExerciseBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }

        let muscleGroupTV = UITableView(frame: .zero, style: .grouped)
        muscleGroupTV.backgroundColor = .clear
        muscleGroupTV.separatorStyle = .none
        
        muscleGroupTV.dataSource = self
        muscleGroupTV.delegate = self
        
        muscleGroupTV.register(ExerciseContentTVC.self, forCellReuseIdentifier: "ExerciseTVC")
        
        view.addSubview(muscleGroupTV)
        
        muscleGroupTV.snp.makeConstraints {
            $0.top.equalTo(addExerciseBtn.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension ExerciseContentController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return musclesDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTVC", for: indexPath) as? ExerciseContentTVC
        cell?.musclesGroup = musclesDataArray[indexPath.section]
        cell?.setupLayout()
        return cell ?? UITableViewCell()
    }
}
