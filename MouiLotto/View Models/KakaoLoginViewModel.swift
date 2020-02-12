//
//  KakaoLoginViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/12.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift

class KakaoLoginViewModel {
    var loginState$ = BehaviorSubject<KakaoLoginState>(value: KakaoLoginState.logout)
    
    func kakaoLogin() {
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
            
            KOSessionTask.userMeTask(completion: { (error, user) in
                guard let user = user,
                let email = user.account?.email,
                let nickname = user.nickname else { return }
                self.loginState$.onNext(KakaoLoginState.selectionProfile)
            })
        })
    }
}
