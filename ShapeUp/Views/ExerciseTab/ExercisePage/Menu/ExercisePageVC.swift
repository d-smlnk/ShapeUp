//
//  ViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit
import RealmSwift

class ExercisePageVC: UIViewController {
    
    static var muscleGroupNameDelegate: String?
    
    private let musclesDataArray: [(UIImage, String, Int)] = [
        (UIImage(named: "Neck") ?? UIImage(), "Neck", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Neck").count),
        (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Chest").count),
        (UIImage(named: "BackMuscle") ?? UIImage(), "Back", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Back").count),
        (UIImage(named: "LegMuscle") ?? UIImage(), "Legs", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Legs").count),
        (UIImage(named: "ShouldersMuscle") ?? UIImage(), "Shoulders", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Shoulders").count),
        (UIImage(named: "HandsMuscles") ?? UIImage(), "Biceps", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Biceps").count),
        (UIImage(named: "TricepsMuscle") ?? UIImage(), "Triceps", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Triceps").count),
        (UIImage(named: "Forearm") ?? UIImage(), "Forearm", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Forearm").count),
        (UIImage(named: "PrelumMuscle") ?? UIImage(), "Core", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Core").count),
        (UIImage(named: "CalvesMuscle") ?? UIImage(), "Calves", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Calves").count),
        (UIImage(named: "Cardio") ?? UIImage(), "Cardio", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Cardio").count),
        (UIImage(named: "Yoga") ?? UIImage(), "Yoga", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Yoga").count),
        (UIImage(named: "Crossfit") ?? UIImage(), "Crossfit", realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", "Crossfit").count)
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
        let vc = ChooseMuscleForNewExerciseVC()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ExercisePageTVC
        ExercisePageVC.muscleGroupNameDelegate = cell?.musclesGroup?.1
        let vc = ChooseExistedExerciseVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
