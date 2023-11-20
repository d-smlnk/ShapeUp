//
//  UserView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

/*
 Авторизація користувача, де він вводить дані про себе такі як вагу, зріст, вік, фізичну активність, стать, ціль(похудати або набрати масу) та відсоток жиру в тілі(Опціонально).
 */

import UIKit
import SnapKit

class UserVC: UIViewController {
    
    private var bgView: UIView!
    private var sexSelectionViews: [UIView] = []
    
    private var dataArrayInTV: [(UITextField, String)] = [
        (UITextField(), "Name"),
        (UITextField(), "Last Name"),
        (UITextField(), "Age"),
        (UITextField(), "Height"),
        (UITextField(), "Weight"),
        (UITextField(), "Indicate your physical activity")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
   
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        
        let womanSexImage = UIImageView(image: UIImage(named: "womanSex"))
        let manSexImage = UIImageView(image: UIImage(named: "manSex"))
        let manSexTitle = "Man"
        let womanSexTitle = "Woman"
        
        let sexSelectionArray: [(UIImageView, String)] = [
            (womanSexImage, womanSexTitle),
            (manSexImage, manSexTitle)
        ]
        
        let sexSelectionSV = UIStackView(arrangedSubviews: sexSelectionArray.map({ (image, title) in
            bgView = UIView()
            bgView.backgroundColor = DS.DesignColorTemplates.secondaryColor
            bgView.layer.cornerRadius = 67.5//bgView.bounds.height / 2
            bgView.layer.masksToBounds = true
            bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseSex)))
            sexSelectionViews.append(bgView)
            bgView.addSubview(image)
 
            let label = UILabel()
            label.text = title
            label.textColor = .black
            label.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .heavy)
            bgView.addSubview(label)
            
            bgView.snp.makeConstraints {
                $0.height.equalTo(bgView.snp.width)
                $0.width.lessThanOrEqualTo(135)
            }
            
            image.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(DS.Paddings.spacing * 4)
            }
            
            label.snp.makeConstraints {
                $0.bottom.equalTo(bgView.snp.bottom).inset(DS.Paddings.spacing)
                $0.centerX.equalTo(bgView.snp.centerX)
            }
            
            image.snp.makeConstraints {
                $0.height.equalTo(image.snp.width)
            }

            return bgView
        }))
        
        sexSelectionSV.distribution = .equalCentering
        sexSelectionSV.isUserInteractionEnabled = true
        view.addSubview(sexSelectionSV)
          
        let userDataTableView = UITableView()
        userDataTableView.delegate = self
        userDataTableView.dataSource = self
        userDataTableView.register(CustomTextFieldTVC.self, forCellReuseIdentifier: CustomTextFieldTVC.reuseIdentifier)
        userDataTableView.backgroundColor = .clear
        userDataTableView.separatorStyle = .none
        view.addSubview(userDataTableView)
        
        let insertUserDataBtn = UIButton()
        insertUserDataBtn.setTitle("Submit", for: .normal)
        insertUserDataBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        insertUserDataBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        insertUserDataBtn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
        insertUserDataBtn.layer.borderWidth = DS.SizeOFElements.customBorderWidth
        insertUserDataBtn.layer.borderColor = DS.DesignColorTemplates.borderColor?.cgColor
        insertUserDataBtn.addTarget(self, action: #selector(insertUserData), for: .touchUpInside)
        view.addSubview(insertUserDataBtn)
        
        sexSelectionSV.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.spacing)
            $0.horizontalEdges.equalToSuperview().inset(DS.Paddings.padding)
        }
         
        insertUserDataBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(DS.Paddings.spacing * 20)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        userDataTableView.snp.makeConstraints {
            $0.top.equalTo(sexSelectionSV.snp.bottom).offset(DS.Paddings.spacing * 2)
            $0.horizontalEdges.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalTo(insertUserDataBtn.snp.top).inset(DS.Paddings.spacing)
        }        
    }
    
    @objc func chooseSex(sender: UITapGestureRecognizer) {
        if let selectedBgView = sender.view {
            for bgView in sexSelectionViews {
                bgView.backgroundColor = (bgView == selectedBgView) ? DS.DesignColorTemplates.borderColor : DS.DesignColorTemplates.secondaryColor
            }
        }
    }
    
    @objc func insertUserData(_ sender: UIButton) {
        navigationController?.pushViewController(MainVC(), animated: true)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension UserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrayInTV.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTextFieldTVC.reuseIdentifier, for: indexPath) as? CustomTextFieldTVC else { return CustomTextFieldTVC() }
        let data = dataArrayInTV[indexPath.row] 
        cell.backgroundColor = .clear
        cell.dataArray = data
        cell.configure(with: data)
        return cell
    }
    
}
