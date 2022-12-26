//
//  MyTableCell.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import UIKit
import SnapKit

final class MyTableCell: UITableViewCell {
    
    var data : PopulationInfo? {
        didSet {
            nation.text = data?.nation
            year.text = data?.year
            population.text = String(data?.population ?? 0)
        }
    }
    
    private let nation = UILabel.getDefaultLabel()
    private let year = UILabel.getDefaultLabel(font: .systemFont(ofSize: 16))
    private let populationLabel = UILabel.getDefaultLabel(text: Constants.populationLabelText)
    private var population = UILabel.getDefaultLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    private func setupLayout() {
        contentView.addSubview(year)
        year.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.leadingTrailingConstraint)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(nation)
        nation.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.leadingTrailingConstraint)
            make.bottom.equalTo(year).inset(Constants.leadingTrailingConstraint)
        }
        contentView.addSubview(populationLabel)
        populationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.leadingTrailingConstraint)
            make.bottom.equalTo(year).inset(Constants.bottomPadding)
        }
        contentView.addSubview(population)
        population.snp.makeConstraints { (make) in
            make.centerY.equalTo(populationLabel)
            make.leading.equalTo(populationLabel).inset(Constants.populationLabelPadding)
        }
    }
}

// MARK: - Constants Enum
fileprivate enum Constants {
    static let populationLabelText = "Population:"
    static let leadingTrailingConstraint = 25
    static let bottomPadding = -25
    static let populationLabelPadding = 90
}
