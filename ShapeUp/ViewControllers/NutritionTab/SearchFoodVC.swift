//
//  SearchFoodVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import UIKit
import RxSwift

class SearchFoodVC: UIViewController {
    
    private var currentPage = 0
    
    private let findMealPageBtn = UIButton()
    private let usedMealPageBtn = UIButton()
    
    private var pageViewController = UIPageViewController()
    private let contentControllers = [SearchNewFoodPageVC(), SearchOldFoogPageVC()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DS.DesignColorTemplates.mainColor

        findMealPageBtn.isUserInteractionEnabled = false
        usedMealPageBtn.isUserInteractionEnabled = false
        
        let btnArray = [(findMealPageBtn, "Find food"),
                        (usedMealPageBtn, "Recent food")]
        
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
        
        let backBtn = backBtn()
        
        // MARK: - CONSTRAINTS
        
        pagesBtnSV.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(pagesBtnSV.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
            $0.bottom.equalTo(backBtn.snp.top).offset(-DS.Paddings.spacing)
        }
        
        backBtn.snp.removeConstraints()
        
        backBtn.snp.makeConstraints {
            $0.height.width.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }

    }
}

//MARK: - Function
extension SearchFoodVC {
    private func updateButtonColors() {
        switch currentPage {
        case 0:
            findMealPageBtn.backgroundColor = DS.DesignColorTemplates.borderColor
            usedMealPageBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
        case 1:
            findMealPageBtn.backgroundColor = DS.DesignColorTemplates.secondaryColor
            usedMealPageBtn.backgroundColor = DS.DesignColorTemplates.borderColor
        default:
            break
        }
    }
}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension SearchFoodVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
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
