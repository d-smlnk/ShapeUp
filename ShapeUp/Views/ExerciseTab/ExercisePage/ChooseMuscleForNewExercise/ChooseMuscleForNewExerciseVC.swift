//
//  ChooseMuscleForNewExerciseVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 31.10.2023.
//

import UIKit

class ChooseMuscleForNewExerciseVC: UIViewController {
    static var muscleGroupNameDelegate: String?
    static var muscleGroupImageDelegate: UIImage?
    
    private let musclesDataArray = [
    (UIImage(named: "Neck") ?? UIImage(), "Neck"),
    (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest"),
    (UIImage(named: "BackMuscle") ?? UIImage(), "Back"),
    (UIImage(named: "LegMuscle") ?? UIImage(), "Legs"),
    (UIImage(named: "ShouldersMuscle") ?? UIImage(), "Shoulders"),
    (UIImage(named: "HandsMuscles") ?? UIImage(), "Biceps"),
    (UIImage(named: "TricepsMuscle") ?? UIImage(), "Triceps"),
    (UIImage(named: "Forearm") ?? UIImage(), "Forearm"),
    (UIImage(named: "PrelumMuscle") ?? UIImage(), "Core"),
    (UIImage(named: "CalvesMuscle") ?? UIImage(), "Calves"),
    (UIImage(named: "Cardio") ?? UIImage(), "Cardio"),
    (UIImage(named: "Yoga") ?? UIImage(), "Yoga"),
    (UIImage(named: "Crossfit") ?? UIImage(), "Crossfit"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.secondaryColor
        
        let backBtn = backBtn()

        let titleOfAction = UILabel()
        titleOfAction.text = "New exercise"
        titleOfAction.font = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .bold)
        
        let headerSV = UIStackView(arrangedSubviews: [backBtn, titleOfAction])
        headerSV.axis = .horizontal
        headerSV.distribution = .fillProportionally
        headerSV.spacing = CGFloat(Paddings.spacing)
        
        let titleOfTV = UILabel()
        titleOfTV.text = "Choose a muscle group:"
        titleOfTV.font = .systemFont(ofSize: Fonts.titleFontSize, weight: .bold)
        
        let labelSV = UIStackView(arrangedSubviews: [headerSV, titleOfTV])
        labelSV.axis = .vertical
        labelSV.distribution = .fillEqually
        labelSV.spacing = CGFloat(SizeOFElements.heightForSingleElements / 2)
        
        view.addSubview(labelSV)
        
        labelSV.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Paddings.padding)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
        }
        
        let musclesGroupTV = UITableView(frame: .zero, style: .grouped)
        
        musclesGroupTV.delegate = self
        musclesGroupTV.dataSource = self
        musclesGroupTV.register(ChooseMuscleForNewExerciseTVC.self, forCellReuseIdentifier: "musclesGroup")
        
        musclesGroupTV.backgroundColor = DesignColorTemplates.secondaryColor
        musclesGroupTV.separatorStyle = .none
            
        view.addSubview(musclesGroupTV)
        
        musclesGroupTV.snp.makeConstraints {
            $0.top.equalTo(labelSV.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension ChooseMuscleForNewExerciseVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musclesDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "musclesGroup", for: indexPath) as? ChooseMuscleForNewExerciseTVC else { return UITableViewCell() }
        cell.musclesGroup = musclesDataArray[indexPath.row]
        cell.selectionStyle = .none
        cell.configure()
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ChooseMuscleForNewExerciseTVC
        ChooseMuscleForNewExerciseVC.muscleGroupNameDelegate = cell?.musclesGroup?.1
        ChooseMuscleForNewExerciseVC.muscleGroupImageDelegate = cell?.musclesGroup?.0
        
        halfScreenPresent(self, presentedVC: CreateExerciseVC())
    }
}
    
