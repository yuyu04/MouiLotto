//
//  NoticeViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/10.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxCocoa

class NoticeViewModel {
    let list$ = BehaviorRelay<[NoticeData]>(value: [])
    
    func setList(list: [NoticeData]) {
        self.list$.accept(list)
    }
}
