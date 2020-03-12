//
//  PurchaseHistoryViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/03.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PurchaseHistoryViewModel {
    let history$ = BehaviorRelay<[String]>(value: [])
    let payResult$ = BehaviorRelay<[[Int]]>(value: [])
    let winningNumbers$ = BehaviorRelay<[Int]>(value: [])
    let lottoResult$ = BehaviorRelay<Int>(value: 0)
    
    func setHistory(_ list: [String]) {
        self.history$.accept(list)
    }
    
    func setPayResult(_ list: [[Int]]) {
        self.payResult$.accept(list)
    }
    
    func setWinningNumbers(_ list: [Int]) {
        self.winningNumbers$.accept(list)
    }
    
    func setLottoResult(_ result: Int) {
        self.lottoResult$.accept(result)
    }
}

