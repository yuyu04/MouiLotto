//
//  MenualPayViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/21.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class MenualPayViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       super.setUpEventView(eventView)
   }
}
