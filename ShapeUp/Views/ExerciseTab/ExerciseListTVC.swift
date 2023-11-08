//
//  ExerciseListTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 06.11.2023.
//

import UIKit

class ExerciseListTVC: UITableViewCell {
    
    static let reuseIdentifier = "ExerciseListTVC"
    
    var pickedExerciseData: RealmPickedExerciseService?

    private let exerciseLabel = UILabel()
    private let dropDownMenuBtn = UIButton()
    
    private let setsTV = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
                
        backgroundColor = DesignColorTemplates.mainColor
        
        exerciseLabel.textColor = .black
        exerciseLabel.font = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .semibold)
        
        contentView.addSubview(exerciseLabel)
        
        exerciseLabel.snp.makeConstraints {
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Paddings.spacing)
        }
        
        dropDownMenuBtn.addTarget(self, action: #selector(btn), for: .touchUpInside)
        contentView.addSubview(dropDownMenuBtn)
        
        dropDownMenuBtn.snp.makeConstraints {
            $0.height.width.equalTo(SizeOFElements.heightForSingleElements / 2)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Paddings.spacing)
        }
        

    }
    
    func configure() {
        exerciseLabel.text = pickedExerciseData?.exerciseName
        
        dropDownMenuBtn.setImage(UIImage(named: "DropDownMenu"), for: .normal)
        dropDownMenuBtn.setImage(UIImage(named: "HideDroppedMenu"), for: .selected)
    }
    #warning("FIXOUT SETSTV")
    @objc func btn() {
        dropDownMenuBtn.isSelected = !dropDownMenuBtn.isSelected
       
        if dropDownMenuBtn.isSelected {
            contentView.snp.makeConstraints {
                $0.height.equalTo(200)
                $0.edges.equalToSuperview()
            }
            
            setsTV.backgroundColor = .red
            setsTV.allowsSelection = false
            setsTV.delegate = self
            setsTV.dataSource = self
            setsTV.register(SetsTVC.self, forCellReuseIdentifier: SetsTVC.reuseIdentifier)
            
            contentView.addSubview(setsTV)

        } else if !dropDownMenuBtn.isSelected {
            setsTV.removeFromSuperview()
        }
        self.layoutIfNeeded()
    }
}

extension ExerciseListTVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: SetsTVC.reuseIdentifier, for: indexPath) as? SetsTVC
        
        return cell ?? UITableViewCell()
    }
    
    
}
