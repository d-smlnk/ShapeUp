//
//  ExerciseListView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

/*
 Представлення для відображення списку доступних фізичних вправ і тренувальних програм.
 */

import UIKit
import FSCalendar
import RealmSwift

protocol ExerciseNameDelegate: UIViewController {
    var exerciseNameTitle: String? { get }
    var execiseDate: Date? { get }
}

class WorkoutRoutineVC: UIViewController, ExerciseNameDelegate, ExerciseStatDelegate {
    var setDateDelegate: RealmPickedExercisePresenter?

    var didSelectExercise: RealmPickedExercisePresenter?
    
    var execiseDate: Date?
    var exerciseNameTitle: String?

    private var isOpenedSections: [Int: Bool] = [:]
    private var calendarView = UIView()
    private let indicatorView = UIView()
    private var emptyExerciseSV = UIStackView()
    private let trainingsCalendar = FSCalendar()
    private let exerciseListTV = UITableView()
    static var choosenDate = Date()
    private var pickedExerciseDataArray: Results<RealmPickedExercisePresenter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        view.isUserInteractionEnabled = true
        
        let emptyExerciseImg = UIImageView(image: UIImage(named: "EmptyExerciseImg"))
        emptyExerciseImg.alpha = 0.8
        emptyExerciseImg.contentMode = .scaleAspectFit
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = "Add an exercise to record your workout"
        exerciseLabel.textAlignment = .center
        exerciseLabel.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        exerciseLabel.textColor = DS.DesignColorTemplates.customTextColor
        let emptyExerciseArray = [emptyExerciseImg, exerciseLabel]
        
        emptyExerciseSV = UIStackView(arrangedSubviews: emptyExerciseArray)
        emptyExerciseSV.axis = .vertical
        view.addSubview(emptyExerciseSV)
        
        let addExerciseBtn = UIButton()
        addExerciseBtn.setTitle("Add an exercise", for: .normal)
        addExerciseBtn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .heavy)
        addExerciseBtn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
        addExerciseBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        addExerciseBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        addExerciseBtn.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
        view.addSubview(addExerciseBtn)
        
        calendarView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        calendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        calendarView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        calendarView.layer.shadowRadius = 10
        calendarView.layer.shadowOpacity = 10
        calendarView.center = view.center
        view.addSubview(calendarView)

        trainingsCalendar.delegate = self
        trainingsCalendar.dataSource = self
        trainingsCalendar.headerHeight = 20
        trainingsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        trainingsCalendar.appearance.eventDefaultColor = DS.DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.headerTitleColor = DS.DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.headerTitleFont = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .heavy)
        trainingsCalendar.appearance.weekdayTextColor = DS.DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.todayColor = DS.DesignColorTemplates.mainColor
        trainingsCalendar.appearance.titleTodayColor = DS.DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.selectionColor = DS.DesignColorTemplates.borderColor
        trainingsCalendar.tintColor = .darkGray
        trainingsCalendar.select(Date())
        trainingsCalendar.scope = .week
        calendarView.addSubview(trainingsCalendar)
            
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeUp.direction = .up
        
        trainingsCalendar.addGestureRecognizer(swipeDown)
        trainingsCalendar.addGestureRecognizer(swipeUp)
        calendarView.addGestureRecognizer(swipeDown)
        calendarView.addGestureRecognizer(swipeUp)
        
        let indicatorViewHeight = 4
        indicatorView.layer.cornerRadius = CGFloat(indicatorViewHeight / 2)
        indicatorView.backgroundColor = .lightGray
        view.addSubview(indicatorView)
        
        exerciseListTV.backgroundColor = .clear
        exerciseListTV.separatorStyle = .none
        exerciseListTV.bounces = false
        exerciseListTV.delegate = self
        exerciseListTV.dataSource = self
        exerciseListTV.register(ExerciseSetTVC.self, forCellReuseIdentifier: ExerciseSetTVC.reuseIdentifier)
        exerciseListTV.register(AddSetBtnTVC.self, forCellReuseIdentifier: AddSetBtnTVC.reuseIdentifier)
        exerciseListTV.register(WorkoutHeaderCellTVC.self, forCellReuseIdentifier: WorkoutHeaderCellTVC.reuseIdentifier)
        view.addSubview(exerciseListTV)
        
        //MARK: - CONSTRAINTS
        
        emptyExerciseSV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(view.frame.size.width / 2)
        }
        
        addExerciseBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.SizeOFElements.heightForSingleElements)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.size.width / 2)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.size.height / 5)
        }
        
        trainingsCalendar.snp.makeConstraints {
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
        
        exerciseListTV.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalTo(addExerciseBtn.snp.top).offset(-DS.Paddings.spacing)
        }
    }
    
    @objc func dragMainView(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .down:
            UIView.animate(withDuration: 0.3) {
                
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 2.3)
                }
                
                self.indicatorView.backgroundColor = .darkGray
                
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 4.3)
                }
                
                self.view.layoutIfNeeded()
            }
            self.trainingsCalendar.setScope(.month, animated: true)
            
        case .up:
            UIView.animate(withDuration: 0.3) {
                
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 5)
                }
                
                self.indicatorView.backgroundColor = .lightGray
                
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 7)
                }
                
                self.view.layoutIfNeeded()
                
            }
            self.trainingsCalendar.setScope(.week, animated: true)
            
        default: break
        }
    }
    
    @objc func addExercise() {
        let addExercise = WorkoutMenuVC()
        addExercise.modalPresentationStyle = .popover
        present(addExercise, animated: true)
    }
    
    @objc func btn(btn: UIButton) {
        if let isOpened = isOpenedSections[btn.tag] {
            btn.isSelected = !isOpened
            isOpenedSections[btn.tag] = isOpened ? false : true
        } else {
            btn.isSelected = true
            isOpenedSections[btn.tag] = true
        }
        exerciseListTV.reloadData()
    }
    
    @objc func addSet(btn: UIButton) {
        exerciseNameTitle = pickedExerciseDataArray?[btn.tag].exerciseName ?? ""
        let vc = AddWeightAndRepVC()
        vc.exerciseNameTitleDelegate = self
        self.halfScreenPresent(vc)
    }
    
    @objc func copySet(btn: UIButton) {
        exerciseNameTitle = pickedExerciseDataArray?[btn.tag].exerciseName ?? ""
        execiseDate = pickedExerciseDataArray?[btn.tag].exerciseDate ?? Date()
        setDateDelegate = pickedExerciseDataArray?[btn.tag]

        let vc = ExerciseStatVC()
        vc.exerciseNameDelegate = self
        vc.exerciseDateDelegate = self
        vc.exerciseStatDelegate = self
        present(vc, animated: true)
    }
}

//MARK: FSCalendar Delegate & Data Source
extension WorkoutRoutineVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        WorkoutRoutineVC.choosenDate = date
        exerciseListTV.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let data = RealmPresenter.realm.objects(RealmPickedExercisePresenter.self)
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        let dateString = dateFormatter.string(from: date)
        
        if data.map ({ item in
            return dateFormatter.string(from: item.exerciseDate)
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

//MARK: UITableView Delegate & Data Source

extension WorkoutRoutineVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let dateOnly = Calendar.current.startOfDay(for: WorkoutRoutineVC.choosenDate)

        pickedExerciseDataArray = RealmPresenter.realm.objects(RealmPickedExercisePresenter.self)
            .filter("exerciseDate >= %@", dateOnly)
            .filter("exerciseDate < %@", Calendar.current.date(byAdding: .day, value: 1, to: dateOnly) ?? Date())
        
        if pickedExerciseDataArray?.count ?? 0 > 0 {
            emptyExerciseSV.isHidden = true
        } else {
            emptyExerciseSV.isHidden = false
        }
        return pickedExerciseDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = RealmPresenter.filterByDateAndExerciseName(realmDB: RealmPickedExercisePresenter.self, exerciseName: pickedExerciseDataArray?[section].exerciseName ?? "")
        switch didSelectExercise != nil {
        case true:
            return isOpenedSections[section] ?? false ? (didSelectExercise?.weightAndRep.count ?? 0) + 2 : 1
        case false:
            return isOpenedSections[section] ?? false ? data.map { $0.weightAndRep.count }.reduce(0, +) + 2 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutHeaderCellTVC.reuseIdentifier, for: indexPath) as? WorkoutHeaderCellTVC
            cell?.exerciseLabel.text = pickedExerciseDataArray?[indexPath.section].exerciseName
            cell?.dropDownMenuBtn.addTarget(self, action: #selector(btn), for: .touchUpInside)
            cell?.dropDownMenuBtn.tag = indexPath.section
            cell?.dropDownMenuBtn.isSelected = isOpenedSections[indexPath.section] ?? false
            return cell ?? UITableViewCell()
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddSetBtnTVC.reuseIdentifier, for: indexPath) as? AddSetBtnTVC
            cell?.addSetBtn.tag = indexPath.section
            cell?.addSetBtn.addTarget(self, action: #selector(addSet), for: .touchUpInside)
            cell?.copyTrainingBtn.tag = indexPath.section
            cell?.copyTrainingBtn.addTarget(self, action: #selector(copySet), for: .touchUpInside)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseSetTVC.reuseIdentifier, for: indexPath) as? ExerciseSetTVC
            cell?.data = pickedExerciseDataArray?[indexPath.section].weightAndRep[indexPath.row - 1]
            cell?.configure()
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let objectToDelete = pickedExerciseDataArray?[indexPath.section] else { return }
            
            let remainingRows = (pickedExerciseDataArray?[indexPath.section].weightAndRep.count ?? 0) - 1
            
            if remainingRows == 0 {
                do {
                    try? RealmPresenter.realm.write {
                        RealmPresenter.realm.delete(objectToDelete)
                    }
                }
                
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
                
            } else {
                do {
                    try? RealmPresenter.realm.write {
                        RealmPresenter.realm.delete(objectToDelete.weightAndRep[indexPath.row - 1])
                    }
                }
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 {
            return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath)])
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 {
            return UISwipeActionsConfiguration(actions: [deleteSectionWithClosedSection(tableView, forRowAt: indexPath)])
        } else {
            return nil
        }
    }
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: nil) { (action, swipeButtonView, completion) in
            self.exerciseNameTitle = self.pickedExerciseDataArray?[indexPath.section].exerciseName ?? ""
            let vc = ExerciseStatVC()
            vc.exerciseNameDelegate = self
            if let presentationController = vc.presentationController as? UISheetPresentationController {
                presentationController.prefersGrabberVisible = true
            }
            
            self.present(vc, animated: true)
            completion(true)
        }
        let statImg = UIImage(named: "Stat")
        let resizedImg = statImg?.resized(to: CGSize(width: 30, height: 30))
        action.image = resizedImg
        action.backgroundColor = DS.DesignColorTemplates.secondaryColor
        return action
    }
    
    private func deleteSectionWithClosedSection(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UIContextualAction {
        guard let objectToDelete = pickedExerciseDataArray?[indexPath.section] else { return UIContextualAction() }

        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            do {
                try? RealmPresenter.realm.write {
                    RealmPresenter.realm.delete(objectToDelete)
                }
            }
            
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            completion(true)
        }
        action.backgroundColor = .systemRed
        return action
    }
}
