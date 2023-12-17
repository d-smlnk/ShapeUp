//
//  NutritionView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import UIKit
import FSCalendar
import RealmSwift

protocol SendDateAndMealTimeDelegate: AnyObject {
    func sendDateAndMealDelegate(_ date: Date, _ mealTime: String)
}

class NutritionMainVC: UIViewController {
    
    private let mealDataArray: [(String, UIImage?)] = [
        ("Breakfast", UIImage(named: "MorningImage")),
        ("Lunch", UIImage(named: "MidiImage")),
        ("Dinner", UIImage(named: "EveningImage")),
        ("Additional meal", UIImage(named: "AnotherTimeImage"))
    ]
    
    private let nutritionTV = UITableView()
    private let calendarView = UIView()
    private let indicatorView = UIView()
    private let nutritionCalendar = FSCalendar()
    static var choosenDate = Date()
    static private var choosenSection = Int()
    private var isOpenedSections: [Int: Bool] = [:]
    private var pickedFoodRealm: Results<RealmPickedFoodPresenter>?
    private var didSelectMeal: RealmPickedFoodPresenter?
    
    weak var sendDateAndMealDelegate: SendDateAndMealTimeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        
        calendarView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        calendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        calendarView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        calendarView.layer.shadowRadius = 10
        calendarView.layer.shadowOpacity = 10
        calendarView.center = view.center
        view.addSubview(calendarView)

        nutritionCalendar.delegate = self
        nutritionCalendar.dataSource = self
        nutritionCalendar.headerHeight = 20
        nutritionCalendar.appearance.headerMinimumDissolvedAlpha = 0
        nutritionCalendar.appearance.eventDefaultColor = DS.DesignColorTemplates.customTextColor
        nutritionCalendar.appearance.headerTitleColor = DS.DesignColorTemplates.customTextColor
        nutritionCalendar.appearance.headerTitleFont = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .heavy)
        nutritionCalendar.appearance.weekdayTextColor = DS.DesignColorTemplates.customTextColor
        nutritionCalendar.appearance.todayColor = DS.DesignColorTemplates.mainColor
        nutritionCalendar.appearance.titleTodayColor = DS.DesignColorTemplates.customTextColor
        nutritionCalendar.appearance.selectionColor = DS.DesignColorTemplates.borderColor
        nutritionCalendar.tintColor = .darkGray
        nutritionCalendar.select(Date())
        nutritionCalendar.scope = .week
        calendarView.addSubview(nutritionCalendar)
            
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeUp.direction = .up
        
        nutritionCalendar.addGestureRecognizer(swipeDown)
        nutritionCalendar.addGestureRecognizer(swipeUp)
        calendarView.addGestureRecognizer(swipeDown)
        calendarView.addGestureRecognizer(swipeUp)
        
        let indicatorViewHeight = 4
        indicatorView.layer.cornerRadius = CGFloat(indicatorViewHeight / 2)
        indicatorView.backgroundColor = .lightGray
        view.addSubview(indicatorView)
        
        let separatorView = UIView()
        separatorView.backgroundColor = DS.DesignColorTemplates.borderColor
        view.addSubview(separatorView)
        
        let proteinTitle = UILabel()
        proteinTitle.text = "Protein"
        let carbsTitle = UILabel()
        carbsTitle.text = "Carbs"
        let fatTitle = UILabel()
        fatTitle.text = "Fat"
        let ccalTitle = UILabel()
        ccalTitle.text = "Ccal"
        ccalTitle.textAlignment = .right
        
        let proteinNumTitle = UILabel()
        proteinNumTitle.text = "200"
        let carbsNumTitle = UILabel()
        carbsNumTitle.text = "400"
        let fatNumTitle = UILabel()
        fatNumTitle.text = "90"
        let ccalNumTitle = UILabel()
        ccalNumTitle.text = "2500"
        ccalNumTitle.textAlignment = .right
        
        let nutrientsNumSV = UIStackView(arrangedSubviews: [proteinNumTitle, carbsNumTitle, fatNumTitle, ccalNumTitle].map ({
            $0.textColor = DS.DesignColorTemplates.customTextColor
            $0.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
            return $0
        }))
        nutrientsNumSV.axis = .horizontal
        nutrientsNumSV.distribution = .fillEqually
        view.addSubview(nutrientsNumSV)
        
        let nutrientsSV = UIStackView(arrangedSubviews: [proteinTitle, carbsTitle, fatTitle, ccalTitle].map ({
            $0.textColor = DS.DesignColorTemplates.customTextColor
            $0.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
            return $0
        }))
        nutrientsSV.axis = .horizontal
        nutrientsSV.distribution = .fillEqually
        view.addSubview(nutrientsSV)
        
        nutritionTV.delegate = self
        nutritionTV.dataSource = self
        nutritionTV.backgroundColor = DS.DesignColorTemplates.mainColor
        nutritionTV.showsVerticalScrollIndicator = false
        nutritionTV.register(NutritionMainTVC.self, forCellReuseIdentifier: NutritionMainTVC.reuseIdentifier)
        nutritionTV.register(NutritionInfoTVC.self, forCellReuseIdentifier: NutritionInfoTVC.reuseIdentifier)
        view.addSubview(nutritionTV)
        
        //MARK: - CONSTRAINTS
        
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.size.height / 5)
        }
        
        nutritionCalendar.snp.makeConstraints {
            $0.top.equalTo(calendarView.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3)
        }
        
        indicatorView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).inset(DS.Paddings.spacing)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.size.width / 7)
            $0.height.equalTo(indicatorViewHeight)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(DS.Paddings.spacing * 6)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(2)
        }
        
        nutrientsSV.snp.makeConstraints {
            $0.bottom.equalTo(separatorView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.centerX.equalToSuperview()
        }
        
        nutrientsNumSV.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.centerX.equalToSuperview()
        }
        
        nutritionTV.snp.makeConstraints {
            $0.top.equalTo(nutrientsNumSV.snp.bottom).offset(DS.Paddings.spacing)
            $0.horizontalEdges.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }

    }
}

extension NutritionMainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = RealmPresenter.filterByDateAndMealName(realmDB: RealmPickedFoodPresenter.self, mealName: pickedFoodRealm?[section].name ?? "")
        switch didSelectMeal != nil {
        case true:
            return isOpenedSections[section] ?? false ? (didSelectMeal?.foodList.count ?? 0) + 2 : 2
        case false:
            return isOpenedSections[section] ?? false ? data.map { $0.foodList.count }.reduce(0, +) + 2 : 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionMainTVC.reuseIdentifier, for: indexPath) as? NutritionMainTVC
            cell?.mealData = mealDataArray[indexPath.section]
            cell?.configure()
            cell?.addMealBtn.tag = indexPath.section
            cell?.addMealBtn.addTarget(self, action: #selector(openSearchVC), for: .touchUpInside)
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionInfoTVC.reuseIdentifier, for: indexPath) as? NutritionInfoTVC
            cell?.mealLabel.text = pickedFoodRealm?[indexPath.section].name
            print("realm", RealmPresenter.realm.objects(RealmPickedFoodPresenter.self))
            cell?.dropDownMenuBtn.addTarget(self, action: #selector(btn), for: .touchUpInside)
            cell?.dropDownMenuBtn.tag = indexPath.section
            cell?.dropDownMenuBtn.isSelected = isOpenedSections[indexPath.section] ?? false
            return cell ?? UITableViewCell()
            
        default: return UITableViewCell()
        }
    }
    
    
}

//MARK: - FSCALENDAR DELEGATE & DATA SOURCE
extension NutritionMainVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        NutritionMainVC.choosenDate = date
        nutritionTV.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let data = RealmPresenter.realm.objects(RealmPickedFoodPresenter.self)
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        let dateString = dateFormatter.string(from: date)
        
        if data.map ({ item in
            return dateFormatter.string(from: item.date)
        }).contains(dateString) {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }

}

//MARK: - @objc Methods and others

extension NutritionMainVC {
    //Animate calendar func
    @objc func dragMainView(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .down:
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 2.3)
                }
                
                self.indicatorView.backgroundColor = .darkGray
                
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 4.3)
                }
                
                self.view.layoutIfNeeded()
            }
            self.nutritionCalendar.setScope(.month, animated: true)
            
        case .up:
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 5)
                }
                
                self.indicatorView.backgroundColor = .lightGray
                
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 7)
                }
                
                self.view.layoutIfNeeded()
                
            }
            self.nutritionCalendar.setScope(.week, animated: true)
            
        default: break
        }
    }
    
    //Open SearhFoodVC and and set date and meal time data to realm
    @objc func openSearchVC(_ btn: UIButton) {
        NutritionMainVC.choosenSection = btn.tag
        let vc = SearchFoodVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //Chevron func
    @objc func btn(btn: UIButton) {
        if let isOpened = isOpenedSections[btn.tag] {
            btn.isSelected = !isOpened
            isOpenedSections[btn.tag] = isOpened ? false : true
        } else {
            btn.isSelected = true
            isOpenedSections[btn.tag] = true
        }
        nutritionTV.reloadData()
    }
    
    //Delegate Method
    func sendDataToVC() {
        sendDateAndMealDelegate?.sendDateAndMealDelegate(NutritionMainVC.choosenDate, mealDataArray[NutritionMainVC.choosenSection].0)
    }
}
