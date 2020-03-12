//
//  MainEventViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/12.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxCocoa

class EventImageViewModel {
    let events$ = BehaviorRelay<[String]>(value: [])
    let currentRound$ = BehaviorRelay<Int>(value: 0)
    
    func setEvents(_ images: [String]) {
        events$.accept(images)
    }
    
    func setRound(_ round: Int) {
        currentRound$.accept(round)
    }
}
