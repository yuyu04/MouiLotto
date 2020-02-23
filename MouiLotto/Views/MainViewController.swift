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
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        super.setUpViewModel(<#T##eventViewModel: EventViewModel##EventViewModel#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.setUpEventView(stackView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let selectPayTypeController = segue.destination as? SelectPayTypeViewController {
            selectPayTypeController.delegate = self
        }
    }
}
