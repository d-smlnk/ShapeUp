//
//  ChooseExistedExerciseVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import UIKit

class ChooseExistedExerciseVC: UIViewController {
    
    let realmData = realm.objects(RealmExerciseService.self).filter("muscleGroupOfExercise == %@", ExercisePageVC.muscleGroupNameDelegate ?? "")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.secondaryColor
        
        let backBtn = backBtn()
        
        let titleOfAction = UILabel()
        titleOfAction.text = ExercisePageVC.muscleGroupNameDelegate
        titleOfAction.font = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .bold)
        
        let headerSV = UIStackView(arrangedSubviews: [backBtn, titleOfAction])
        headerSV.axis = .horizontal
        headerSV.distribution = .fillProportionally
        headerSV.spacing = CGFloat(Paddings.spacing)
        
        let titleOfTV = UILabel()
        titleOfTV.text = "Choose an exercise:"
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
        musclesGroupTV.register(ChooseExistedExerciseTVC.self, forCellReuseIdentifier: ChooseExistedExerciseTVC.reuseIdentifier)
        
        musclesGroupTV.backgroundColor = DesignColorTemplates.secondaryColor
        musclesGroupTV.separatorStyle = .none
        
        view.addSubview(musclesGroupTV)
        
        musclesGroupTV.snp.makeConstraints {
            $0.top.equalTo(labelSV.snp.bottom).offset(Paddings.spacing)
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
//        let cell = tableView.cellForRow(at: indexPath) as? ChooseExistedExerciseTVC
        print(realmData)
        print(realmData.count)
    }
    
    
}
