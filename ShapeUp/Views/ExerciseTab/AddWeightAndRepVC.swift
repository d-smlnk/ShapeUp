//
//  AddSetAndRepVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit

class AddWeightAndRepVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = DesignColorTemplates.mainColor
        
        let setAndRepTV = UITableView()
        setAndRepTV.backgroundColor = DesignColorTemplates.mainColor
        setAndRepTV.dataSource = self
        setAndRepTV.delegate = self
        setAndRepTV.register(AddSetAndRepTVC.self, forCellReuseIdentifier: AddSetAndRepTVC.reuseIdentifier)
        view.addSubview(setAndRepTV)
        
        let addSetBtn = UIButton()
        addSetBtn.backgroundColor = DesignColorTemplates.borderColor
        addSetBtn.setTitle("Add set to exercise", for: .normal)
        view.addSubview(addSetBtn)
        
        addSetBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Paddings.spacing)
            $0.width.equalTo(view.frame.width / 2)
        }
        
        setAndRepTV.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addSetBtn.snp.top).offset(-Paddings.spacing)
        }
    }

}

extension AddWeightAndRepVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddSetAndRepTVC.reuseIdentifier, for: indexPath) as? AddSetAndRepTVC
        cell?.configure()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}
