//
//  ExerciseSetTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.11.2023.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class ExerciseSetTVC: UITableViewCell {

    static let reuseIdentifier = "ExerciseSetTVC"
    
    private let weightTF = UITextField(image: UIImage(named: "scale") ?? UIImage(), placeholder: "Weight", contentType: .numberPad)
    private let repTF = UITextField(image: UIImage(named: "reps") ?? UIImage(), placeholder: "Rep", contentType: .numberPad)
    private let setAndRepSV = UIStackView()
    
    private let disposeBag = DisposeBag()
        
    var data: RealmWeightAndSetPresenter?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.mainColor
        selectionStyle = .none

        setAndRepSV.axis = .horizontal
        setAndRepSV.distribution = .fillEqually
        setAndRepSV.spacing = CGFloat(DS.Paddings.spacing)
        contentView.addSubview(setAndRepSV)
        
        //MARK: CONSTRAINTS
  
        setAndRepSV.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
    }
    
    func configure() {
        [weightTF, repTF].forEach {
            setAndRepSV.addArrangedSubview($0)
        }
        weightTF.text = data?.weight
        repTF.text = data?.rep
        
        weightTF.rx.text.changed
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                do {
                    try RealmPresenter.realm.write {
                        self.data?.weight = text ?? ""
                    }
                } catch {
                    print("Error during updating set: \(error)")
                }
            })
            .disposed(by: disposeBag) 
        
        repTF.rx.text.changed
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                do {
                    try RealmPresenter.realm.write {
                        self.data?.rep = text ?? ""
                    }
                } catch {
                    print("Error during updating set: \(error)")
                }
            })
            .disposed(by: disposeBag)
    }
}
