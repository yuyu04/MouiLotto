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
    var profile = Profile(nickName: "닉네임", email: "")
    
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
                        self.loginState$.onError(error)
                    }
                }
            }
            
            KOSessionTask.userMeTask(completion: { (error, user) in
                if let user = user {
                    if let profile = user.account?.profile {
                        self.profile.nickName = profile.nickname
                    }
                    
                    if let email = user.account?.email {
                        self.profile.email = email
                    }
                    
                    self.loginState$.onNext(KakaoLoginState.selectionProfile)
                }
            })
        })
    }
    
    func setFinishNickName(nickname: String) {
        self.profile.nickName = nickname;
        
        self.loginState$.onNext(KakaoLoginState.login)
    }
}
