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

class ExerciseVC: UIViewController {

    private var calendarView = UIView()
    private let indicatorView = UIView()
    private var emptyExerciseSV = UIStackView()
    private var trainingsCalendar = FSCalendar()
    private let exerciseListTV = UITableView()
    static var choosenDate = Date()
    private var pickedExerciseDataArray: Results<RealmPickedExerciseService>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    

    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
        view.isUserInteractionEnabled = true
        
        let emptyExerciseImg = UIImageView(image: UIImage(named: "EmptyExerciseImg"))
        emptyExerciseImg.alpha = 0.8
        emptyExerciseImg.contentMode = .scaleAspectFit
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = "Add an exercise to record your workout"
        exerciseLabel.textAlignment = .center
        exerciseLabel.font = .systemFont(ofSize: Fonts.separateTextFontSize, weight: .semibold)
        exerciseLabel.textColor = DesignColorTemplates.customTextColor
        let emptyExerciseArray = [emptyExerciseImg, exerciseLabel]
        
        emptyExerciseSV = UIStackView(arrangedSubviews: emptyExerciseArray)
        emptyExerciseSV.axis = .vertical
        
        view.addSubview(emptyExerciseSV)
        
        emptyExerciseSV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.height.equalTo(view.frame.size.width / 2)
        }
        
        let addExerciseBtn = UIButton()
        addExerciseBtn.setTitle("Add an exercise", for: .normal)
        addExerciseBtn.titleLabel?.font = .systemFont(ofSize: Fonts.separateTextFontSize, weight: .heavy)
        addExerciseBtn.setTitleColor(DesignColorTemplates.customTextColor, for: .normal)
        addExerciseBtn.backgroundColor = DesignColorTemplates.secondaryColor
        addExerciseBtn.layer.cornerRadius = SizeOFElements.customCornerRadius
        addExerciseBtn.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
        
        view.addSubview(addExerciseBtn)

        addExerciseBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeOFElements.heightForSingleElements)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.size.width / 2)
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }
        
        calendarView.backgroundColor = DesignColorTemplates.secondaryColor
        calendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        calendarView.layer.cornerRadius = SizeOFElements.customCornerRadius
        calendarView.layer.shadowRadius = 10
        calendarView.layer.shadowOpacity = 10

        calendarView.center = view.center
        view.addSubview(calendarView)

        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.size.height / 5)
        }
        
        trainingsCalendar.delegate = self
        trainingsCalendar.dataSource = self
        
        trainingsCalendar.headerHeight = 20
        trainingsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        trainingsCalendar.appearance.eventDefaultColor = DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.headerTitleColor = DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.headerTitleFont = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .heavy)
        trainingsCalendar.appearance.weekdayTextColor = DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.todayColor = DesignColorTemplates.mainColor
        trainingsCalendar.appearance.titleTodayColor = DesignColorTemplates.customTextColor
        trainingsCalendar.appearance.selectionColor = DesignColorTemplates.borderColor
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

        trainingsCalendar.snp.makeConstraints {
            $0.top.equalTo(calendarView.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3)
        }
        
        indicatorView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).inset(Paddings.spacing)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.size.width / 7)
            $0.height.equalTo(indicatorViewHeight)
        }
        
        exerciseListTV.backgroundColor = .clear
        exerciseListTV.allowsSelection = false
        exerciseListTV.bounces = false
        exerciseListTV.delegate = self
        exerciseListTV.dataSource = self
        exerciseListTV.register(ExerciseListTVC.self, forCellReuseIdentifier: ExerciseListTVC.reuseIdentifier)
        
        view.addSubview(exerciseListTV)
        
        exerciseListTV.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.bottom.equalTo(addExerciseBtn.snp.top).offset(-Paddings.spacing)
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
        let addExercise = AddExerciseVC()
        addExercise.modalPresentationStyle = .popover
        present(addExercise, animated: true)
    }
    
}

//MARK: FSCalendar Delegate & Data Source
extension ExerciseVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        ExerciseVC.choosenDate = date
        exerciseListTV.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {

        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
}

//MARK: UITableView Delegate & Data Source

extension ExerciseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dateOnly = Calendar.current.startOfDay(for: ExerciseVC.choosenDate)
        pickedExerciseDataArray = realm.objects(RealmPickedExerciseService.self).filter("exerciseDate >= %@", dateOnly).filter("exerciseDate < %@", Calendar.current.date(byAdding: .day, value: 1, to: dateOnly)!)
        
        if pickedExerciseDataArray?.count ?? 0 > 0 {
            emptyExerciseSV.isHidden = true
        } else {
            emptyExerciseSV.isHidden = false
        }
        return pickedExerciseDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseListTVC.reuseIdentifier, for: indexPath) as? ExerciseListTVC
        cell?.pickedExerciseData = pickedExerciseDataArray?[indexPath.row]
        cell?.configure()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let objectToDelete = pickedExerciseDataArray?[indexPath.row] {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.delete(objectToDelete)
                    }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                } catch {
                    print("Ошибка при удалении объекта из Realm: \(error)")
                }
            }
        }
        
    }
}
