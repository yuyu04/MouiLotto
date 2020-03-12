//
//  LottoPaperView.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/05.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class LottoPaperView: UIView {
    @IBOutlet weak var lottoCount: UILabel!
    @IBOutlet weak var lottoPublishDay: UILabel!
    @IBOutlet weak var lottoDrawDay: UILabel!
    @IBOutlet weak var lottoSerialNumber: UILabel!
    @IBOutlet weak var lottoSerialNumber2: UILabel!
    
    @IBOutlet var lottoGameNumber: [UILabel]!
    @IBOutlet var lottoMenualAndAuto: [UILabel]!
    
    @IBOutlet var lottoGame1: [UILabel]!
    @IBOutlet var lottoGame2: [UILabel]!
    @IBOutlet var lottoGame3: [UILabel]!
    @IBOutlet var lottoGame4: [UILabel]!
    @IBOutlet var lottoGame5: [UILabel]!
    
    @IBOutlet weak var lottoMoney: UILabel!
    @IBOutlet weak var lottoTotalPay: UILabel!
    @IBOutlet weak var lottoSerialNumber3: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    class func instanceFromNib() -> LottoPaperView {
        return UINib(nibName: "LottoPaperView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LottoPaperView
    }
    
    public func setUp() {
        lottoCount.fitTextToBounds()
        lottoPublishDay.fitTextToBounds()
        lottoDrawDay.fitTextToBounds()
        lottoSerialNumber.fitTextToBounds()
        lottoSerialNumber2.fitTextToBounds()
        lottoMoney.fitTextToBounds()
        lottoTotalPay.fitTextToBounds()
        lottoSerialNumber3.fitTextToBounds()

        for label in lottoGameNumber {
            label.fitTextToBounds()
        }

        for label in lottoMenualAndAuto {
            label.fitTextToBounds()
        }

        for label in lottoGame1 {
            label.fitTextToBounds()
        }

        for label in lottoGame2 {
            label.fitTextToBounds()
        }

        for label in lottoGame3 {
            label.fitTextToBounds()
        }

        for label in lottoGame4 {
            label.fitTextToBounds()
        }

        for label in lottoGame5 {
            label.fitTextToBounds()
        }
    }
    
    func getFontColor(_ value: Int) -> UIColor {
        return UIColor()
    }
}
