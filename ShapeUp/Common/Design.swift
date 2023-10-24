//
//  Design.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import Foundation
import UIKit
import DGCharts

let padding = 16
let spacingElements = 8
let fontSize: CGFloat = 15

let mainColor = UIColor(hex: 0x08FFC8)
let secondaryColor = UIColor(hex: 0xD5EEBB)
let borderColor = UIColor(hex: 0x5F7A61)
let customTextColor = UIColor(hex: 0x444941)

let heightForSingleElements = 50
let customBorderWidth: CGFloat = 2
let customCornerRadius: CGFloat = 10

func createPieChart(doneNum: Int, totalNum: Int, labelText: String) -> UIStackView {
    let pieChartSvWithDesc = UIStackView()
    pieChartSvWithDesc.axis = .vertical
    pieChartSvWithDesc.spacing = CGFloat(-spacingElements)

    let pieChart = PieChartView()
    pieChart.widthAnchor.constraint(equalToConstant: 120).isActive = true
    pieChart.heightAnchor.constraint(equalToConstant: 120).isActive = true

    let chartDoneLabel = String(doneNum)
    let chartDoneLabelText = chartDoneLabel.count > 4 ? "..." : chartDoneLabel
    let attributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 25, weight: .heavy),
        .foregroundColor: UIColor.white
    ]

    let chartDescription = UILabel()
    chartDescription.text = labelText
    chartDescription.textAlignment = .center
    chartDescription.numberOfLines = 0
    chartDescription.textColor = customTextColor
    chartDescription.font = .systemFont(ofSize: 17, weight: .medium)

    pieChart.centerAttributedText = NSAttributedString(string: chartDoneLabelText, attributes: attributes)
    pieChart.holeColor = borderColor
    pieChart.legend.enabled = false
    pieChart.transparentCircleRadiusPercent = CGFloat(0.7)

    let doneRatio = Double(doneNum) / Double(totalNum)
    let notDoneRatio = 1.0 - doneRatio

    let dataEntries: [ChartDataEntry] = [
        PieChartDataEntry(value: doneRatio),
        PieChartDataEntry(value: notDoneRatio)
    ]

    let colors: [UIColor] = [borderColor ?? .red, .clear]
    let dataSet = PieChartDataSet(entries: dataEntries)
    dataSet.drawValuesEnabled = false
    dataSet.colors = colors
    pieChart.transparentCircleColor = secondaryColor

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




//func createPieChart(doneNum: Int, totalNum: Int, labelText: String) -> UIStackView {
//
//    let pieChartSvWithDesc = UIStackView()
//    pieChartSvWithDesc.axis = .vertical
//    pieChartSvWithDesc.spacing = CGFloat(-spacingElements)
//
//    let pieChart = PieChartView()
//    pieChart.widthAnchor.constraint(equalToConstant: 120).isActive = true
//    pieChart.heightAnchor.constraint(equalToConstant: 120).isActive = true
//
//    let chartDoneLabel = String(doneNum)
//    let attributes: [NSAttributedString.Key : Any] = [
//        .font: UIFont.systemFont(ofSize: 25, weight: .heavy),
//        .foregroundColor: UIColor.white
//    ]
//
//    let chartDescription = UILabel()
//    chartDescription.text = labelText
//    chartDescription.textAlignment = .center
//    chartDescription.numberOfLines = 2
//    chartDescription.textColor = customTextColor
//    chartDescription.font = .systemFont(ofSize: 17, weight: .medium)
//
//    pieChart.centerAttributedText = NSAttributedString(string: chartDoneLabel, attributes: attributes)
//    pieChart.holeColor = borderColor
//    pieChart.legend.enabled = false
//    pieChart.transparentCircleRadiusPercent = CGFloat(0.7)
//
//    let dataEntries: [ChartDataEntry] = [
//        PieChartDataEntry(value: Double(doneNum)),
//        PieChartDataEntry(value: Double(totalNum))
//    ]
//
//    let colors: [UIColor] = [borderColor ?? .black, .clear]
//    let dataSet = PieChartDataSet(entries: dataEntries)
//    dataSet.drawValuesEnabled = false
//    dataSet.colors = colors
//    pieChart.transparentCircleColor = secondaryColor
//
//    let data = PieChartData(dataSet: dataSet)
//    pieChart.data = data
//    pieChartSvWithDesc.addArrangedSubview(pieChart)
//    pieChartSvWithDesc.addArrangedSubview(chartDescription)
//    // Устанавливаем максимальный размер шрифта, который поместится в круге
//    pieChartSvWithDesc.layoutIfNeeded()
//    let maxFontSize = pieChart.frame.size.width * 0.5 // Зависит от радиуса круга
//
//    if let currentFont = chartDescription.font, maxFontSize < currentFont.pointSize {
//            let newFont = UIFont.systemFont(ofSize: maxFontSize, weight: .heavy)
//            chartDescription.font = newFont
//            pieChart.centerAttributedText = NSAttributedString(string: chartDoneLabelText, attributes: [.font: newFont, .foregroundColor: UIColor.white])
//        }
//
//    return pieChartSvWithDesc
//}
