//
//  DoNotRefundView.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class DoNotRefundView: UIView {
    @IBOutlet weak var totalMoney: UILabel!
    
    class func instanceFromNib() -> DoNotRefundView {
        return UINib(nibName: "DoNotRefundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DoNotRefundView
    }
}
