//
//  RefundMoneyViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxCocoa

class RefundViewModel {
    let totalMoney$ = BehaviorRelay<Int64>(value: 0)
    
    func setMoney(_ money: Int64) {
        self.totalMoney$.accept(money)
    }
}
