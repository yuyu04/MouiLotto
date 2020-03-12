//
//  DoRefundView.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class DoRefundView: UIView {
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var refundMoney: UITextField!
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBookAddress: UITextField!
    @IBOutlet weak var bankBookName: UITextField!
    @IBOutlet weak var refundButton: UIButton!
    
    class func instanceFromNib() -> DoRefundView {
        return UINib(nibName: "DoRefundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DoRefundView
    }
}
