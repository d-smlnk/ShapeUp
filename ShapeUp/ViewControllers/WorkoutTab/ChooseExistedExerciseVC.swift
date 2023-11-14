//
//  ChooseExistedExerciseVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import UIKit
import RealmSwift

class ChooseExistedExerciseVC: UIViewController {
    
    let realmData = realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", ExercisePageVC.muscleGroupNameDelegate ?? "")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.secondaryColor
        
        let backBtn = backBtn()
        
        let titleOfAction = UILabel()
        titleOfAction.text = ExercisePageVC.muscleGroupNameDelegate
        titleOfAction.font = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .bold)
        
        let headerSV = UIStackView(arrangedSubviews: [backBtn, titleOfAction])
        headerSV.axis = .horizontal
        headerSV.distribution = .fillProportionally
        headerSV.spacing = CGFloat(DS.Paddings.spacing)
        
        let titleOfTV = UILabel()
        titleOfTV.text = "Choose an exercise:"
        titleOfTV.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .bold)
        
        let labelSV = UIStackView(arrangedSubviews: [headerSV, titleOfTV])
        labelSV.axis = .vertical
        labelSV.distribution = .fillEqually
        labelSV.spacing = CGFloat(DS.SizeOFElements.heightForSingleElements / 2)
        
        view.addSubview(labelSV)
        
        labelSV.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        let musclesGroupTV = UITableView(frame: .zero, style: .grouped)
        
        musclesGroupTV.delegate = self
        musclesGroupTV.dataSource = self
        musclesGroupTV.register(ChooseExistedExerciseTVC.self, forCellReuseIdentifier: ChooseExistedExerciseTVC.reuseIdentifier)
        
        musclesGroupTV.backgroundColor = DS.DesignColorTemplates.secondaryColor
        musclesGroupTV.separatorStyle = .none
        
        view.addSubview(musclesGroupTV)
        
        musclesGroupTV.snp.makeConstraints {
            $0.top.equalTo(labelSV.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension ChooseExistedExerciseVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseExistedExerciseTVC.reuseIdentifier, for: indexPath) as? ChooseExistedExerciseTVC
        cell?.realmData = realmData[indexPath.row]
        cell?.configure()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ChooseExistedExerciseTVC
        
        let settings = RealmPickedExerciseService()
        do {
            try realm.write({
                settings.exerciseName = cell?.exerciseNameLabel.text ?? "No exercise name"
                settings.exerciseDate = ExerciseVC.choosenDate
                realm.add(settings)
            })
        } catch {}
        dismiss(animated: true)
    }
    
    
}
