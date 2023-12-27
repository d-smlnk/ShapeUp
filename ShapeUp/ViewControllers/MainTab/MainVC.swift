//
//  MainView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import UIKit
import DGCharts

class MainVC: UIViewController {
    
    private var exercisesCV: UICollectionView?
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
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
    
        let nameLabel = UILabel()
        nameLabel.text = "Hi Your Name,"
        nameLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .medium)
        nameLabel.textColor = DS.DesignColorTemplates.customTextColor
        view.addSubview(nameLabel)
        
        let staticLabel = UILabel()
        staticLabel.text = "Get In Shape!"
        staticLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy)
        staticLabel.textColor = DS.DesignColorTemplates.customTextColor
        view.addSubview(staticLabel)
        
        let infoView = UIView()
        infoView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        infoView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        view.addSubview(infoView)
        
        let womanImage = UIImage(named: "WomanImg")
        
        let imageView = UIImageView(image: womanImage)
        infoView.addSubview(imageView)
        
        let weightPiechart = CreateCustomPieChart.createPieChart(doneNum: 70, totalNum: 80, labelText: "Goal Weight")
        infoView.addSubview(weightPiechart)
        
        let ccalPiechart = CreateCustomPieChart.createPieChart(doneNum: 1200, totalNum: 1500, labelText: "Eaten today")
        infoView.addSubview(ccalPiechart)
        
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
         
        let separatorView = UIView()
        separatorView.backgroundColor = DS.DesignColorTemplates.borderColor
        view.addSubview(separatorView)
        
        let cellTitle = UILabel()
        cellTitle.text = "Your exercises"
        cellTitle.textColor = DS.DesignColorTemplates.customTextColor
        cellTitle.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy)
        view.addSubview(cellTitle)
        
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
        
        //MARK: CONSTRAINTS
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.spacing * 7)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        staticLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(staticLabel.snp.bottom).offset(DS.Paddings.spacing * 7)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(250)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-80)
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(imageView.snp.height).dividedBy(2.4)
        }
        
        weightPiechart.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        ccalPiechart.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(weightPiechart.snp.trailing)
        }
        
        infoSV.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalToSuperview().inset(DS.Paddings.spacing)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(DS.Paddings.spacing * 5)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(2)
        }
        
        cellTitle.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(DS.Paddings.padding)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
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
