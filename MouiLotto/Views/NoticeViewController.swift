//
//  NoticeViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/24.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class NoticeViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
    }

}
