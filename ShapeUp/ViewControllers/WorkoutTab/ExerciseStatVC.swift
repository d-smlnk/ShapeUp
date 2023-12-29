//
//  ExerciseStatVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 02.12.2023.
//

import UIKit
import RealmSwift

protocol ExerciseStatDelegate: UIViewController {
    var didSelectExercise: RealmPickedExercisePresenter? { get set }
    var setDateDelegate: RealmPickedExercisePresenter? { get set }
}

class ExerciseStatVC: UIViewController {
    weak var exerciseStatDelegate: ExerciseStatDelegate?
    
    var data: Results<RealmPickedExercisePresenter>?
    weak var exerciseNameDelegate: ExerciseNameDelegate?
    weak var exerciseDateDelegate: ExerciseNameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.secondaryColor
        data = RealmPresenter.realm.objects(RealmPickedExercisePresenter.self).filter("exerciseName == %@", exerciseNameDelegate?.exerciseNameTitle ?? "")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2.5, height: view.frame.height / 5)
        layout.scrollDirection = .vertical
        
        let statCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        statCV.backgroundColor = DS.DesignColorTemplates.secondaryColor
        statCV.dataSource = self
        statCV.delegate = self
        statCV.register(StatCVC.self, forCellWithReuseIdentifier: StatCVC.reuseIdentifier)
        view.addSubview(statCV)
                
        let exerciseLabel = UILabel()
        exerciseLabel.text = exerciseNameDelegate?.exerciseNameTitle ?? ""
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
        let sortedData = data?.sorted(by: { $0.exerciseDate < $1.exerciseDate })
        cell?.data = sortedData?[indexPath.row]
        cell?.configure()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if exerciseDateDelegate != nil {
            let selectedCell = collectionView.cellForItem(at: indexPath) as? StatCVC
            exerciseStatDelegate?.didSelectExercise = selectedCell?.data
            do {
                try RealmPresenter.realm.write {
                    exerciseStatDelegate?.setDateDelegate?.weightAndRep = exerciseStatDelegate?.didSelectExercise?.weightAndRep ?? List<RealmWeightAndSetPresenter>()
                }
            } catch {
                print("Failed to add copied set to Realm Data Base")
            }
            dismiss(animated: true)
        }
    }
    
}
