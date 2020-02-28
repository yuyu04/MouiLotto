//
//  RandomPayViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/21.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class RandomPayViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       super.setUpEventView(eventView)
   }
}
