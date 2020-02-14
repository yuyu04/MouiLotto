//
//  KakaoLoginViewModel.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/12.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class KakaoLoginViewModel {
    var loginState$ = BehaviorSubject<KakaoLoginState>(value: KakaoLoginState.logout)
    var profile = Profile(nickName: "닉네임", email: "", token: "")
    
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
    
    func saveProfileCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
             fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
             do
             {
                 let test = try managedContext.fetch(fetchRequest)
        
                     let objectUpdate = test[0] as! NSManagedObject
                     objectUpdate.setValue("newName", forKey: "username")
                     objectUpdate.setValue("newmail", forKey: "email")
                     objectUpdate.setValue("newpassword", forKey: "password")
                     do{
                         try managedContext.save()
                     }
                     catch
                     {
                         print(error)
                     }
                 }
             catch
             {
                 print(error)
             }
        
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            self.loginState$.onNext(KakaoLoginState.logout)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteProfileCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        
    }
    
    func setFinishNickName(nickname: String) {
        self.profile.nickName = nickname;
        
        self.loginState$.onNext(KakaoLoginState.login)
    }
}
