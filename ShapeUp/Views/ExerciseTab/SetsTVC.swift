//
//  SetsTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 08.11.2023.
//

import UIKit

class SetsTVC: UITableViewCell {
    
    static let reuseIdentifier = "SetsTVC"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        backgroundColor = .blue
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.edges.equalToSuperview()
        }
        
        
    }
    
}
