//
//  MyTableCell.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import UIKit
import SnapKit

final class MyTableCell: UITableViewCell {
    
    var data : Data? {
        didSet {
            nation.text = data?.nation
            year.text = data?.year
            population.text = String(data?.population ?? 0)
        }
    }
    
    
    private let nation : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
        
    private let year : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let populationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Population:"
        label.textColor = .black
        return label
    }()
    
    var population : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(nation)
        contentView.addSubview(year)
        contentView.addSubview(populationLabel)
        contentView.addSubview(population)
        
        year.snp.makeConstraints { (make) in
            make.leading.equalTo(25)
            make.centerY.equalTo(contentView)
        }
        
        nation.snp.makeConstraints { (make) in
            make.leading.equalTo(25)
            make.bottom.equalTo(year).inset(25)
        }
        
        populationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(25)
            make.bottom.equalTo(year).inset(-25)
        }
        population.snp.makeConstraints { (make) in
            make.centerY.equalTo(populationLabel)
            make.leading.equalTo(populationLabel).inset(90)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
