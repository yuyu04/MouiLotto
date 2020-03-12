//
//  RankingCell.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class RankingCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var ranking: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
