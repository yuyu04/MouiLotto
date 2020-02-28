//
//  MainViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift

class MainViewController: CustomNavigationViewController {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let selectPayTypeController = segue.destination as? SelectPayTypeViewController {
            selectPayTypeController.delegate = self
        }
    }
}
