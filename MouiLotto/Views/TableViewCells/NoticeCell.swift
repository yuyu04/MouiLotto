//
//  NoticeCell.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/10.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class NoticeCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var scrollImage: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
