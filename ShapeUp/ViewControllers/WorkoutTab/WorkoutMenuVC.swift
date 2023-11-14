//
//  AddExerciseViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 26.10.2023.
//

import UIKit

class WorkoutMenuVC: UIViewController {
    private var currentPage = 0
    private let exercisePageBtn = UIButton()
    private let programPageBtn = UIButton()
    private var pageViewController = UIPageViewController()
    private let contentControllers = [ExercisePageVC(), ProgramPageVC()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor
                
        let searchExerciseBar = UISearchBar()
        searchExerciseBar.placeholder = "Search an exercise"
        searchExerciseBar.barTintColor = DS.DesignColorTemplates.mainColor
        searchExerciseBar.delegate = self
        
        view.addSubview(searchExerciseBar)
        
        searchExerciseBar.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        exercisePageBtn.isUserInteractionEnabled = false
        programPageBtn.isUserInteractionEnabled = false
        
        let btnArray = [(exercisePageBtn, "Exercises"),
                        (programPageBtn, "Programs")]
        
        let pagesBtnSV = UIStackView(arrangedSubviews: btnArray.map({ item in
            let btn = item.0
            btn.setTitle(item.1, for: .normal)
            updateButtonColors()
            btn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            btn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .heavy)
            
            return btn
        }))
        
        pagesBtnSV.axis = .horizontal
        pagesBtnSV.spacing = CGFloat(DS.Paddings.spacing)
        pagesBtnSV.distribution = .fillEqually
        view.addSubview(pagesBtnSV)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.setViewControllers([contentControllers.first ?? UIViewController()], direction: .reverse, animated: true, completion: nil)
        self.addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        //MARK: CONSTRAINTS

        pagesBtnSV.snp.makeConstraints {
            $0.top.equalTo(searchExerciseBar.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(pagesBtnSV.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func updateButtonColors() {
        switch currentPage {
        case 0:
            exercisePageBtn.backgroundColor = DS.DesignColorTemplates.borderColor
            programPageBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        case 1:
            exercisePageBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
            programPageBtn.backgroundColor = DS.DesignColorTemplates.borderColor
        default:
            break
        }
    }
}

//MARK: SearchBar Delegate
#warning("MAKE SEARCHBAR DELEGATE")
extension WorkoutMenuVC: UISearchBarDelegate {
    
}

//MARK: PAGECONTROL DELEGATE & DATASOURCE

extension WorkoutMenuVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contentControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return contentControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contentControllers.firstIndex(of: viewController), index < contentControllers.count - 1 else {
            return nil
        }
        return contentControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let viewController = pageViewController.viewControllers?.first,
               let index = contentControllers.firstIndex(of: viewController) {
                currentPage = index
                updateButtonColors()
            }
        }
    }
}
