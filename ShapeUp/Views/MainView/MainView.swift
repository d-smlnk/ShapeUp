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

class MainView: UIViewController {
    
    private let musclesDataArray = [
    (UIImage(named: "ChestMuscle") ?? UIImage(), "Chest exercises", 8),
    (UIImage(named: "BackMuscle") ?? UIImage(), "Back exercises", 10),
    (UIImage(named: "LegMuscle") ?? UIImage(), "Leg exercises", 7),
    (UIImage(named: "HandsMuscles") ?? UIImage(), "Hands exercises", 14)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
    
        let nameLabel = UILabel()
        nameLabel.text = "Hi Dmytro Samoilenko,"
        nameLabel.font = .systemFont(ofSize: 25, weight: .medium)
        nameLabel.textColor = DesignColorTemplates.customTextColor
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Paddings.spacing * 7)
            $0.leading.equalToSuperview().inset(Paddings.padding)
        }
        
        let staticLabel = UILabel()
        staticLabel.text = "Get In Shape!"
        staticLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        staticLabel.textColor = DesignColorTemplates.customTextColor
        view.addSubview(staticLabel)

        staticLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Paddings.spacing)
            $0.leading.equalToSuperview().inset(Paddings.padding)
        }
        
        let infoView = UIView()
        infoView.backgroundColor = DesignColorTemplates.secondaryColor
        infoView.layer.cornerRadius = SizeOFElements.customCornerRadius
        view.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(staticLabel.snp.bottom).offset(Paddings.spacing * 7)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
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
        
        let weightPiechart = createPieChart(doneNum: 70, totalNum: 80, labelText: "Goal Weight")
        infoView.addSubview(weightPiechart)
        
        let ccalPiechart = createPieChart(doneNum: 1200, totalNum: 1500, labelText: "Eaten today")
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
            container.layer.cornerRadius = SizeOFElements.customCornerRadius
            container.layer.borderWidth = SizeOFElements.customBorderWidth
            container.layer.borderColor = DesignColorTemplates.borderColor?.cgColor
            
            let label = UILabel()
            let labelText = "\(title) \(stringGoal ?? "")\(intGoal?.description ?? "")"
            
            label.text = labelText
            label.textColor = DesignColorTemplates.customTextColor
            label.font = .systemFont(ofSize: Fonts.fontSize, weight: .medium)
            label.numberOfLines = 0
            label.setContentHuggingPriority(.required, for: .vertical)
            
            container.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalTo(container).inset(Paddings.spacing)
            }
            
            if labelText.contains("\n") {
                label.lineBreakMode = .byWordWrapping
            }
            
            return container
        }))
        
        infoSV.axis = .vertical
        infoSV.spacing = CGFloat(Paddings.spacing)
        infoView.addSubview(infoSV)
        
        infoSV.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Paddings.padding)
            $0.bottom.equalToSuperview().inset(Paddings.spacing)
        }
                
        let separatorView = UIView()
        separatorView.backgroundColor = DesignColorTemplates.borderColor
        
        view.addSubview(separatorView)
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(Paddings.spacing * 5)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.height.equalTo(2)
        }
        
        let cellTitle = UILabel()
        cellTitle.text = "Your exercises"
        cellTitle.textColor = DesignColorTemplates.customTextColor
        cellTitle.font = .systemFont(ofSize: 25, weight: .heavy)
        view.addSubview(cellTitle)
        
        cellTitle.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(Paddings.padding)
            $0.leading.equalToSuperview().inset(Paddings.padding)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        layout.scrollDirection = .horizontal
        
        let exercisesCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        exercisesCV.showsHorizontalScrollIndicator = false
        exercisesCV.dataSource = self
        exercisesCV.delegate = self
        
        exercisesCV.register(MusclesGroupsCVC.self, forCellWithReuseIdentifier: "musclesCVC")
        exercisesCV.backgroundColor = .clear
        
        view.addSubview(exercisesCV)
        
        exercisesCV.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.bottom.equalToSuperview().inset(150)
        }
        
    }
}

extension MainView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musclesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musclesCVC", for: indexPath) as? MusclesGroupsCVC
        let musclesData = musclesDataArray[indexPath.item]
        cell?.musclesDataArrayInCVC = musclesData
        cell?.setupLayout()
        return cell ?? UICollectionViewCell()
    }
}
