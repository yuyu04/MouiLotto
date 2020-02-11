//
//  LoginViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {

    @IBAction func login(_ sender: AnyObject) {
        guard let session = KOSession.shared() else {
            return
        }

        if session.isOpen() {
            session.close()
        }
        
        session.open(completionHandler: { (error) -> Void in
            
            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        UIAlertController.showMessage(error.description)
                    }
                }
            }
        })
    }
}
