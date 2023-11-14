//
//  MainView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

/*
 Головний екран додатку включає в себе профіль користувача, графік (бар чарт), що відображає співвідношення між спожитими калоріями та калоріями, які потрібно спожити, а також налаштування цілей та можливість введення зміни ваги.
 */

import UIKit
import DGCharts

class MainVC: UIViewController {
    
    #warning("FIXOUT WHY filterElementsByGroup DONT WORKING")
    private var exercisesCV: UICollectionView?
    private var musclesDataArray: [(UIImage, String, Int)] = [
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
    ] {
        didSet {
            exercisesCV?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
    
        let nameLabel = UILabel()
        nameLabel.text = "Hi Dmytro Samoilenko,"
        nameLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .medium)
        nameLabel.textColor = DS.DesignColorTemplates.customTextColor
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.spacing * 7)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        let staticLabel = UILabel()
        staticLabel.text = "Get In Shape!"
        staticLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy)
        staticLabel.textColor = DS.DesignColorTemplates.customTextColor
        view.addSubview(staticLabel)

        staticLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        let infoView = UIView()
        infoView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        infoView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        view.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(staticLabel.snp.bottom).offset(DS.Paddings.spacing * 7)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(250)
        }
        
        let womanImage = UIImage(named: "WomanImg")
        let imageView = UIImageView(image: womanImage)
        infoView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-80)
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(imageView.snp.height).dividedBy(2.4)
        }
        let weightPiechart = CreateCustomPieChart.createPieChart(doneNum: 70, totalNum: 80, labelText: "Goal Weight")
        infoView.addSubview(weightPiechart)
        
        let ccalPiechart = CreateCustomPieChart.createPieChart(doneNum: 1200, totalNum: 1500, labelText: "Eaten today")
        infoView.addSubview(ccalPiechart)
        
        weightPiechart.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        ccalPiechart.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(weightPiechart.snp.trailing)
        }
        
        let infoArray: [(String, String?, Int?)] = [
            ("Goal:", "Losing weight", nil),
            ("Calories:", nil, 1500)
        ]
        
        let infoSV = UIStackView(arrangedSubviews: infoArray.map({ (title, stringGoal, intGoal) in
            let container = UIView()
            container.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            container.layer.borderWidth = DS.SizeOFElements.customBorderWidth
            container.layer.borderColor = DS.DesignColorTemplates.borderColor?.cgColor
            
            let label = UILabel()
            let labelText = "\(title) \(stringGoal ?? "")\(intGoal?.description ?? "")"
            
            label.text = labelText
            label.textColor = DS.DesignColorTemplates.customTextColor
            label.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .medium)
            label.numberOfLines = 0
            label.setContentHuggingPriority(.required, for: .vertical)
            
            container.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalTo(container).inset(DS.Paddings.spacing)
            }
            
            if labelText.contains("\n") {
                label.lineBreakMode = .byWordWrapping
            }
            
            return container
        }))
        
        infoSV.axis = .vertical
        infoSV.spacing = CGFloat(DS.Paddings.spacing)
        infoView.addSubview(infoSV)
        
        infoSV.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalToSuperview().inset(DS.Paddings.spacing)
        }
                
        let separatorView = UIView()
        separatorView.backgroundColor = DS.DesignColorTemplates.borderColor
        
        view.addSubview(separatorView)
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(DS.Paddings.spacing * 5)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(2)
        }
        
        let cellTitle = UILabel()
        cellTitle.text = "Your exercises"
        cellTitle.textColor = DS.DesignColorTemplates.customTextColor
        cellTitle.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy)
        view.addSubview(cellTitle)
        
        cellTitle.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(DS.Paddings.padding)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        layout.scrollDirection = .horizontal
        
        exercisesCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        exercisesCV?.showsHorizontalScrollIndicator = false
        exercisesCV?.dataSource = self
        exercisesCV?.delegate = self
        
        exercisesCV?.register(MusclesGroupsCVC.self, forCellWithReuseIdentifier: MusclesGroupsCVC.reuseIdentifier)
        exercisesCV?.backgroundColor = .clear
        
        view.addSubview(exercisesCV ?? UICollectionView())
        
        exercisesCV?.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalToSuperview().inset(150)
        }
        
    }
}

//MARK: COLLECTIONVIEW DELEGATE & DATASOURCE

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musclesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusclesGroupsCVC.reuseIdentifier, for: indexPath) as? MusclesGroupsCVC
        let musclesData = musclesDataArray[indexPath.item]
        cell?.musclesDataArrayInCVC = musclesData
        cell?.configure()
        return cell ?? UICollectionViewCell()
    }
}