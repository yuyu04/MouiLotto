//
//  ProfileSelectionViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/12.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift
import MapleBacon

class ProfileSelectionViewController: UIViewController {
    var loginViewModel: KakaoLoginViewModel?
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        self.nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel?.setFinishNickName(nickname: self?.nickName.text ?? "닉네임")
            })
            .disposed(by: disposeBag)
        
        if let profile = self.loginViewModel?.profile {
            self.nickName.text = profile.nickName
        } else {
            self.nickName.text = "닉네임"
        }
    }
}
