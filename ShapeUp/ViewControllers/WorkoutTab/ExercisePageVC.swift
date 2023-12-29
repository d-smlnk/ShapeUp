//
//  ViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 30.10.2023.
//

import UIKit
import RealmSwift
import RxSwift
import RxRealm

class ExercisePageVC: UIViewController {
    
    static var muscleGroupNameDelegate: String?
    
    private let muscleGroupTV = UITableView(frame: .zero, style: .grouped)

    private var musclesDataArray: [(UIImage, String, Int)] = [] {
        didSet {
            muscleGroupTV.reloadData()
        }
    }
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupMuscleDataArray()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCount()
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

//MARK: - Other Methods

extension ExercisePageVC {
    // Create exercises for Collection view
    private func createMuscleData(imageName: String, title: String) -> (UIImage, String, Int) {
        let image = UIImage(named: imageName) ?? UIImage()
        let realmExercise = RealmPresenter.realm.objects(RealmExercisePresenter.self)
        var count = RealmPresenter.numberOfFilteredElements(realmDB: RealmExercisePresenter.self, filterBy: "muscleGroupOfExercise", for: title)

        return (image, title, count)
    }
    // setup data for collection view
    private func setupMuscleDataArray() {
        musclesDataArray = [
        createMuscleData(imageName: "Neck", title: "Neck"),
        createMuscleData(imageName: "ChestMuscle", title: "Chest"),
        createMuscleData(imageName: "BackMuscle", title: "Back"),
        createMuscleData(imageName: "LegMuscle", title: "Legs"),
        createMuscleData(imageName: "ShouldersMuscle", title: "Shoulders"),
        createMuscleData(imageName: "HandsMuscles", title: "Biceps"),
        createMuscleData(imageName: "TricepsMuscle", title: "Triceps"),
        createMuscleData(imageName: "Forearm", title: "Forearm"),
        createMuscleData(imageName: "PrelumMuscle", title: "Core"),
        createMuscleData(imageName: "CalvesMuscle", title: "Calves"),
        createMuscleData(imageName: "Cardio", title: "Cardio"),
        createMuscleData(imageName: "Yoga", title: "Yoga"),
        createMuscleData(imageName: "Crossfit", title: "Crossfit")
        ]
    }
    
    // Update collectionview when new exercise was added
    private func updateCount() {
        let realmExercise = RealmPresenter.realm.objects(RealmExercisePresenter.self)
        Observable.changeset(from: realmExercise)
            .subscribe(onNext: { [weak self] changeset in
                guard let self = self else { return }
                guard let inserted = changeset.1?.inserted, !inserted.isEmpty else { return }
                
                self.setupMuscleDataArray()
                
                print("Inserted: \(inserted.count)")
            })
            .disposed(by: disposeBag)
    }
}
