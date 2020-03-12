//
//  MainPageViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/02.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxCocoa

class MainPageViewModel {
    let status$ = BehaviorRelay<MainPageStatus>(value: MainPageStatus.purchase)
    
    func setStatus(event: MainPageStatus) {
        self.status$.accept(event)
    }
}
