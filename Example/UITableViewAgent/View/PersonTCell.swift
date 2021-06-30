//
//  PersonTCell.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class PersonTCell: UITableViewCell {
    
    let lblName = UILabel()
    let lblAge = UILabel()
    let lblGender = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(lblName)
        self.contentView.addSubview(lblAge)
        self.contentView.addSubview(lblGender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblName.frame = CGRect(x: 15, y: 15, width: 200, height: 20)
        lblAge.frame = CGRect(x: 15, y: 40, width: 100, height: 20)
        lblGender.frame = CGRect(x: self.contentView.bounds.size.width - 60, y: 40, width: 60, height: 20)
    }
}
