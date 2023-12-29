//
//  PieChart.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 31.10.2023.
//

import Foundation
import DGCharts
import UIKit

class CreateCustomPieChart: UIView {
    static func createPieChart(doneNum: Int, totalNum: Int, labelText: String) -> UIStackView {
        let pieChartSvWithDesc = UIStackView()
        pieChartSvWithDesc.axis = .vertical
        pieChartSvWithDesc.spacing = CGFloat(-DS.Paddings.spacing)
        
        let pieChart = PieChartView()
        pieChart.highlightPerTapEnabled = false
        pieChart.rotationEnabled = false
        
        let chartDoneLabel = String(doneNum)
        let chartDoneLabelText = chartDoneLabel.count > 4 ? "..." : chartDoneLabel
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy),
            .foregroundColor: UIColor.white
        ]
        
        let chartDescription = UILabel()
        chartDescription.text = labelText
        chartDescription.textAlignment = .center
        chartDescription.numberOfLines = 0
        chartDescription.textColor = DS.DesignColorTemplates.customTextColor
        chartDescription.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .medium)
        
        pieChart.centerAttributedText = NSAttributedString(string: chartDoneLabelText, attributes: attributes)
        pieChart.holeColor = DS.DesignColorTemplates.borderColor
        pieChart.legend.enabled = false
        pieChart.transparentCircleRadiusPercent = CGFloat(0.7)
        
        let doneRatio = Double(doneNum) / Double(totalNum)
        let notDoneRatio = 1.0 - doneRatio
        
        let dataEntries: [ChartDataEntry] = [
            PieChartDataEntry(value: doneRatio),
            PieChartDataEntry(value: notDoneRatio)
        ]
        
        let colors: [UIColor] = [DS.DesignColorTemplates.borderColor ?? .red, .clear]
        let dataSet = PieChartDataSet(entries: dataEntries)
        dataSet.drawValuesEnabled = false
        dataSet.colors = colors
        pieChart.transparentCircleColor = DS.DesignColorTemplates.secondaryColor
        
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChartSvWithDesc.addArrangedSubview(pieChart)
        pieChartSvWithDesc.addArrangedSubview(chartDescription)
        
        pieChartSvWithDesc.layoutIfNeeded()
        let maxFontSize = pieChart.frame.size.width * 0.5
        
        if let currentFont = chartDescription.font, maxFontSize < currentFont.pointSize {
            let newFont = UIFont.systemFont(ofSize: maxFontSize, weight: .heavy)
            pieChart.centerAttributedText = NSAttributedString(string: chartDoneLabelText, attributes: [.font: newFont, .foregroundColor: UIColor.white])
        }
        return pieChartSvWithDesc
    }
}
