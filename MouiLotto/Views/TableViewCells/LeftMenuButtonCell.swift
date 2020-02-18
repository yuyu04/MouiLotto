//
//  LeftMenuButtonCell.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/15.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class LeftMenuButtonCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var buttonText: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 2)];
//        line.backgroundColor = [UIColor redColor];
//        [cell addSubview:line];
    }
}
