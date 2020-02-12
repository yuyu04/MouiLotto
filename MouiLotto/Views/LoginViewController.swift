//
//  LoginViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {
    var loginViewModel: KakaoLoginViewModel!

    @IBAction func login(_ sender: AnyObject) {
        loginViewModel.kakaoLogin()
    }
}
