//
//  RankingViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxCocoa

class RankingViewModel {
    let history$ = BehaviorRelay<[String]>(value: [])
    let list$ = BehaviorRelay<[RankingData]>(value: [])
    
    func setHistory(_ list: [String]) {
        self.history$.accept(list)
    }
    
    func setList(_ list: [RankingData]) {
        self.list$.accept(list)
    }
}
