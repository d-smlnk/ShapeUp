//
//  MainTabBarController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 22.10.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(vc: WorkoutRoutineVC(), title: "Workout", image: UIImage(named: "WorkoutImg")),
            generateVC(vc: MainVC(), title: "", image: UIImage(named: "mainTabBarBtn")),
            generateVC(vc: NutritionVC(), title: "Meal", image: UIImage(named: "MealImg"))
        ]
        self.selectedIndex = 1
    }
    
    private func generateVC(vc : UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
    private func setTabBarAppearance() {
        
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = DS.DesignColorTemplates.secondaryColor?.cgColor
        tabBar.tintColor = DS.DesignColorTemplates.customTextColor
        tabBar.unselectedItemTintColor = DS.DesignColorTemplates.borderColor
    }

}
