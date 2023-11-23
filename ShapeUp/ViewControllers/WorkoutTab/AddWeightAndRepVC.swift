//
//  AddSetAndRepVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit
import RealmSwift

class AddWeightAndRepVC: UIViewController {
    
    weak var exerciseNameTitleDelegate: ExerciseNameDelegate?
    
    var weightAndSetData: Results<RealmPickedExerciseService>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.secondaryColor
                
        let setAndRepTV = UITableView()
        setAndRepTV.backgroundColor = DS.DesignColorTemplates.secondaryColor
        setAndRepTV.separatorStyle = .none
        setAndRepTV.dataSource = self
        setAndRepTV.delegate = self
        setAndRepTV.register(AddWeightAndRepTVC.self, forCellReuseIdentifier: AddWeightAndRepTVC.reuseIdentifier)
        view.addSubview(setAndRepTV)
        
        let saveData = UIButton()
        saveData.backgroundColor = DS.DesignColorTemplates.borderColor
        saveData.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        saveData.addTarget(self, action: #selector(saveWeightAndSet), for: .touchUpInside)
        saveData.setTitle("Save and exit", for: .normal)
        view.addSubview(saveData)
        
        //MARK: CONSTRAINTS

        saveData.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.spacing)
            $0.width.equalTo(view.frame.width / 2)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        setAndRepTV.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Paddings.padding * 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalTo(saveData.snp.top).offset(-DS.Paddings.spacing)
        }

    }

}

extension AddWeightAndRepVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        weightAndSetData = RealmPresenter.filterByDateAndExerciseName(realmDB: RealmPickedExerciseService.self, exerciseName: exerciseNameTitleDelegate?.exerciseNameTitle ?? "NONAME")

        return weightAndSetData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddWeightAndRepTVC.reuseIdentifier, for: indexPath) as? AddWeightAndRepTVC
        cell?.weightAndSetData = weightAndSetData?[indexPath.row]
        cell?.configure()
        return cell ?? UITableViewCell()
    }
    
    @objc func saveWeightAndSet() {
        do {
            let settings = RealmWeightAndSet()
            try RealmPresenter.realm.write {
                settings.weight = AddWeightAndRepTVC.weightTF.text ?? "0"
                settings.rep = AddWeightAndRepTVC.repTF.text ?? "0"
                weightAndSetData?.first?.weightAndRep.append(settings)
                RealmPresenter.realm.add(settings)
            }
        } catch {
            print("Error to add weight and/or set \(error)")
        }
        
        print(weightAndSetData ?? "")
        
        weightAndSetData!.forEach({ item in
            print(item.weightAndRep.count)
        })
        dismiss(animated: true)
    }
}
