//
//  SelectPayTypeViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/19.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class SelectPayTypeViewController: UIViewController {
    var delegate: MainViewController?
    
    func showViewController(_ viewControllerName: String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: viewControllerName)
        self.dismiss(animated: true) { () -> Void in
            self.delegate?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func showRandomViewController(_ sender: AnyObject) {
        self.showViewController("RandomPay")
    }
    
    @IBAction func showMenualViewControoler(_ sender: AnyObject) {
        self.showViewController("MenualPay")
    }

    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true)
    }
}
