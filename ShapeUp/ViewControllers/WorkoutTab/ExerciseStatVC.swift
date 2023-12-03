//
//  ExerciseStatVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.12.2023.
//

import UIKit
import RealmSwift

class ExerciseStatVC: UIViewController {
        
    var data: Results<RealmPickedExerciseService>?
    weak var exerciseName: ExerciseNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.secondaryColor
        
        data = RealmPresenter.realm.objects(RealmPickedExerciseService.self).filter("exerciseName == %@", exerciseName?.exerciseNameTitle ?? "")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        layout.scrollDirection = .vertical
        
        let statCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        statCV.backgroundColor = DS.DesignColorTemplates.secondaryColor
        statCV.dataSource = self
        statCV.delegate = self
        statCV.register(StatCVC.self, forCellWithReuseIdentifier: StatCVC.reuseIdentifier)
        view.addSubview(statCV)
                
        let exerciseLabel = UILabel()
        exerciseLabel.text = exerciseName?.exerciseNameTitle ?? ""
        exerciseLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .semibold)
        view.addSubview(exerciseLabel)
        
        //MARK: - CONSTRAINTS
        
        exerciseLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        
        statCV.snp.makeConstraints {
            $0.top.equalTo(exerciseLabel.snp.bottom).offset(DS.Paddings.spacing * 2)
            $0.leading.trailing.bottom.equalToSuperview().inset(DS.Paddings.padding)
        }
    }
}

extension ExerciseStatVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatCVC.reuseIdentifier, for: indexPath) as? StatCVC
        cell?.data = data?[indexPath.row]
        cell?.configure()
        return cell ?? UICollectionViewCell()
    }
    
}
