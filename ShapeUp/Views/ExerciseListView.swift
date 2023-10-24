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

class ExerciseListView: UIViewController {

    private var calendarView = UIView()
    private let indicatorView = UIView()
    private var trainingsCalendar = UICalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    

    private func setupLayout() {
        view.backgroundColor = mainColor
        view.isUserInteractionEnabled = true
        calendarView.backgroundColor = secondaryColor
        calendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        calendarView.layer.cornerRadius = customCornerRadius
        calendarView.layer.shadowRadius = 10
        calendarView.layer.shadowOpacity = 10

        calendarView.center = view.center
        view.addSubview(calendarView)

        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.size.height / 7)
        }
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        trainingsCalendar.delegate = self
        
        trainingsCalendar.calendar = Calendar(identifier: .gregorian)
        trainingsCalendar.availableDateRange = DateInterval(start: .distantPast, end: .now)
        trainingsCalendar.tintColor = .darkGray
        trainingsCalendar.selectionBehavior = selection
        
        calendarView.addSubview(trainingsCalendar)
            
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dragMainView))
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
        
        let indicatorViewHeight = 4
        indicatorView.layer.cornerRadius = CGFloat(indicatorViewHeight / 2)
        indicatorView.backgroundColor = .lightGray
        view.addSubview(indicatorView)

        trainingsCalendar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(padding)
        }
        
        indicatorView.snp.makeConstraints {
            $0.top.equalTo(trainingsCalendar.snp.bottom).offset(spacingElements)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.size.width / 7)
            $0.height.equalTo(indicatorViewHeight)
        }

    }
    
    @objc func dragMainView(_ gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            switch gesture.direction {
            case .down:
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 1.4)
                }
                
                self.indicatorView.backgroundColor = .darkGray
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 4.3)
                }
                
            case .up:
                self.calendarView.snp.updateConstraints {
                    $0.height.equalTo(self.view.frame.size.height / 7)
                }
                
                self.indicatorView.backgroundColor = .lightGray
                self.indicatorView.snp.updateConstraints {
                    $0.width.equalTo(self.view.frame.size.width / 7)
                }
                                
            default: break
            }
            self.view.layoutIfNeeded()
        }
    }
    
}

extension ExerciseListView: UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents ?? DateComponents())
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let day = dateComponents.day else { return nil}
        
        if day.isMultiple(of: 2) {
            return UICalendarView.Decoration.default(color: mainColor, size: .large)
        }
        return nil
    }
}
