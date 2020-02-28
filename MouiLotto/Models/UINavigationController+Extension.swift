//
//  UINavigationController+Extension.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/24.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class NavigationController: UINavigationController {

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
