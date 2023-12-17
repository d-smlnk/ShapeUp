//
//  CalendarView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 09.12.2023.
//

import UIKit
import FSCalendar
#warning("learn how to create custom view with animation for further using in other classes")
class CalendarView: UIView {
    
    let nutritionCalendar = FSCalendar()
    let indicatorView = UIView()

    override func layoutSubviews() {
        super.layoutSubviews()
        print("Setting up CalendarView")
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = DS.DesignColorTemplates.secondaryColor
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.center = self.center

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
        addSubview(nutritionCalendar)
        
        let indicatorViewHeight = 4
        
        indicatorView.layer.cornerRadius = CGFloat(indicatorViewHeight / 2)
        indicatorView.backgroundColor = .lightGray
        addSubview(indicatorView)
        
        //MARK: - CONSTRAINTS
        
        indicatorView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).inset(DS.Paddings.spacing)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.size.width / 7)
            $0.height.equalTo(indicatorViewHeight)
        }
        
        nutritionCalendar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.frame.height)
        }
        
    }
}

//MARK: - FSCALENDAR DELEGATE & DATA SOURCE
extension CalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        layoutIfNeeded()
    }
}
