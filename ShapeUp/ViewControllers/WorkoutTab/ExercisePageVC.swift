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
    
    private let muscleGroupTV = UITableView(frame: .zero, style: .grouped)

    private var musclesDataArray: [(UIImage, String, Int)] = [
        (UIImage(named: "Neck") ?? UIImage(), "Neck", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Neck")),
        (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Chest")),
        (UIImage(named: "BackMuscle") ?? UIImage(), "Back", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Back")),
        (UIImage(named: "LegMuscle") ?? UIImage(), "Legs", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Legs")),
        (UIImage(named: "ShouldersMuscle") ?? UIImage(), "Shoulders", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Shoulders")),
        (UIImage(named: "HandsMuscles") ?? UIImage(), "Biceps", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Biceps")),
        (UIImage(named: "TricepsMuscle") ?? UIImage(), "Triceps", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Triceps")),
        (UIImage(named: "Forearm") ?? UIImage(), "Forearm", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Forearm")),
        (UIImage(named: "PrelumMuscle") ?? UIImage(), "Core", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Core")),
        (UIImage(named: "CalvesMuscle") ?? UIImage(), "Calves", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Calves")),
        (UIImage(named: "Cardio") ?? UIImage(), "Cardio", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Cardio")),
        (UIImage(named: "Yoga") ?? UIImage(), "Yoga", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Yoga")),
        (UIImage(named: "Crossfit") ?? UIImage(), "Crossfit", RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: "Crossfit"))
    ] {
        didSet {
            muscleGroupTV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        
        let createExerciseBtn = UIButton()
        createExerciseBtn.setTitle("Create an exercise", for: .normal)
        createExerciseBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        createExerciseBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        createExerciseBtn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
        createExerciseBtn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .heavy)
        createExerciseBtn.addTarget(self, action: #selector(goToMuscleGroupMenu), for: .touchUpInside)
        view.addSubview(createExerciseBtn)
        
        muscleGroupTV.backgroundColor = .clear
        muscleGroupTV.separatorStyle = .none
        muscleGroupTV.dataSource = self
        muscleGroupTV.delegate = self
        muscleGroupTV.register(ExercisePageTVC.self, forCellReuseIdentifier: ExercisePageTVC.reuseIdentifier)
        view.addSubview(muscleGroupTV)
        
        //MARK: CONSTRAINTS
        
        createExerciseBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        muscleGroupTV.snp.makeConstraints {
            $0.top.equalTo(createExerciseBtn.snp.bottom).offset(DS.Paddings.spacing)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ExercisePageTVC.reuseIdentifier, for: indexPath) as? ExercisePageTVC
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
