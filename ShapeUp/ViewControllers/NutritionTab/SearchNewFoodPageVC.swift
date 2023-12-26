//
//  SearchNewFoodPageVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 14.12.2023.
//

import UIKit
import RxSwift
import RxRealm

protocol SendQueryDelegate: AnyObject {
    var queryDelegate: String? { get set }
}

protocol SendNutritionDataDelegate: AnyObject {
    var nutritionDataDelegate: NutritionModel? { get set }
}

class SearchNewFoodPageVC: UIViewController, SendQueryDelegate, SendNutritionDataDelegate {
    
    var nutritionDataDelegate: NutritionModel?
    
    var queryDelegate: String?

    private let searchBar = UISearchBar()
    private let foodTV = UITableView()
    private var foodData = [NutritionModel]()
    private var emptyFoodListSV = UIStackView()

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
 
        view.backgroundColor = DS.DesignColorTemplates.mainColor
        
        searchBar.delegate = self
        
        if let clearBtn = searchBar.searchTextField.value(forKey: "clearButton") as? UIButton {
            clearBtn.addTarget(self, action: #selector(dismissSearch), for: .touchUpInside)
        }
        
        let findBtn = UIButton()
        
        let findFoodSV = UIStackView(arrangedSubviews: [(searchBar, findBtn)].map { searchBar, btn in
            let svView = UIView()
            
            searchBar.searchBarStyle = .minimal
            searchBar.barTintColor = DS.DesignColorTemplates.mainColor
            svView.addSubview(searchBar)
            
            btn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            btn.backgroundColor = DS.DesignColorTemplates.secondaryColor
            btn.setTitle("Search", for: .normal)
            btn.setTitleColor(DS.DesignColorTemplates.customTextColor, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .medium)
            btn.addTarget(self, action: #selector(findFood), for: .touchUpInside)
            svView.addSubview(btn)

            //MARK: - CONSTRAINTS OF FINDFOODSV ELEMENTS
            
            searchBar.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview()
                $0.width.equalTo(self.view.frame.width / 1.3)
            }
            
            btn.snp.makeConstraints {
                $0.top.trailing.bottom.equalToSuperview().inset(6)
                $0.leading.equalTo(searchBar.snp.trailing)
            }
            
            return svView
        })
        view.addSubview(findFoodSV)

        foodTV.delegate = self
        foodTV.dataSource = self
        foodTV.register(SearchFoodTVC.self, forCellReuseIdentifier: SearchFoodTVC.reuseIdentifier)
        foodTV.backgroundColor = .clear
        foodTV.isHidden = true
        view.addSubview(foodTV)
        
        let emptyFoodListImg = UIImageView(image: UIImage(named: "EmptyFoodListImg"))
        emptyFoodListImg.alpha = 0.8
        emptyFoodListImg.contentMode = .scaleAspectFit
        
        let emptyFoodListLabel = UILabel()
        emptyFoodListLabel.text = "Add a meal to record your nutrition"
        emptyFoodListLabel.textAlignment = .center
        emptyFoodListLabel.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        emptyFoodListLabel.textColor = DS.DesignColorTemplates.customTextColor
        
        let emptyFoodListArray = [emptyFoodListImg, emptyFoodListLabel]
        
        emptyFoodListSV = UIStackView(arrangedSubviews: emptyFoodListArray)
        emptyFoodListSV.axis = .vertical
        view.addSubview(emptyFoodListSV)
        
        // MARK: - CONSTRAINTS
        
        findFoodSV.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        foodTV.snp.makeConstraints {
            $0.top.equalTo(findFoodSV.snp.bottom).offset(DS.Paddings.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        
        emptyFoodListSV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(view.frame.size.width / 2)
        }
        
    }
    
}

//MARK: - API request completion
extension SearchNewFoodPageVC {
    private func fetch() {
        NutritionPresenter.shared.fetchMeals { response in
            switch response {
            case .success(let foodData):
                self.foodData = foodData
                self.foodTV.isHidden = false
                self.emptyFoodListSV.isHidden = true
                self.foodTV.reloadData()
                print(foodData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchNewFoodPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        queryDelegate = searchText
        NutritionPresenter.shared.queryDelegate = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchNewFoodPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchFoodTVC.reuseIdentifier, for: indexPath) as? SearchFoodTVC
        cell?.mealData = foodData[indexPath.row]
        cell?.configure()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MealVC()
        nutritionDataDelegate = foodData[indexPath.row]
        vc.nutritionData = self
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(DS.SizeOFElements.heightForSingleElements)
    }
}

//MARK: - @objc METHODS
extension SearchNewFoodPageVC {
    @objc func findFood(_ searchBar: UISearchBar) {
        fetch()
    }
    
    @objc func dismissSearch() {
        foodTV.isHidden = true
        emptyFoodListSV.isHidden = false
    }
}
