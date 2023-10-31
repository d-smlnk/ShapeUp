//
//  AddExerciseViewController.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 26.10.2023.
//

import UIKit

class AddExerciseViewController: UIViewController {
    private var currentPage = 0
    private let exercisePageBtn = UIButton()
    private let programPageBtn = UIButton()
    private var pageViewController = UIPageViewController()
    private let contentControllers = [ExerciseContentController(), ProgramContentController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
        
        let searchExerciseBar = UISearchBar()
        searchExerciseBar.placeholder = "Search an exercise"
        searchExerciseBar.barTintColor = DesignColorTemplates.mainColor
        searchExerciseBar.delegate = self
        
        view.addSubview(searchExerciseBar)
        
        searchExerciseBar.snp.makeConstraints {
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Paddings.padding)
        }
        
        exercisePageBtn.isUserInteractionEnabled = false
        programPageBtn.isUserInteractionEnabled = false
        
        let btnArray = [(exercisePageBtn, "Exercises"),
                        (programPageBtn, "Programs")]
        
        let pagesBtnSV = UIStackView(arrangedSubviews: btnArray.map({ item in
            let btn = item.0
            btn.setTitle(item.1, for: .normal)
            updateButtonColors()
            btn.layer.cornerRadius = SizeOFElements.customCornerRadius
            btn.setTitleColor(DesignColorTemplates.customTextColor, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: Fonts.fontSize, weight: .heavy)
            
            return btn
        }))
        
        pagesBtnSV.axis = .horizontal
        pagesBtnSV.spacing = CGFloat(Paddings.spacing)
        pagesBtnSV.distribution = .fillEqually
        
        view.addSubview(pagesBtnSV)
        
        pagesBtnSV.snp.makeConstraints {
            $0.top.equalTo(searchExerciseBar.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
        }
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.setViewControllers([contentControllers.first ?? UIViewController()], direction: .reverse, animated: true, completion: nil)
        
        view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(pagesBtnSV.snp.bottom).offset(Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(Paddings.padding)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func updateButtonColors() {
        switch currentPage {
        case 0:
            exercisePageBtn.backgroundColor = DesignColorTemplates.borderColor
            programPageBtn.backgroundColor = DesignColorTemplates.secondaryColor
        case 1:
            exercisePageBtn.backgroundColor = DesignColorTemplates.secondaryColor
            programPageBtn.backgroundColor = DesignColorTemplates.borderColor
        default:
            break
        }
    }
}

//MARK: SearchBar Delegate
extension AddExerciseViewController: UISearchBarDelegate {
    
    
}

//MARK: PAGECONTROL DELEGATE & DATASOURCE

extension AddExerciseViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
