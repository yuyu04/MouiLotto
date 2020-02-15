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
    
    func findProfileCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                let user = result[0] as! NSManagedObject
                self.profile.email = user.value(forKey: "email") as! String
                self.profile.nickName = user.value(forKey: "name") as! String
                self.profile.token = user.value(forKey: "token") as! String
                self.loginState$.onNext(KakaoLoginState.login)
            }
        } catch {
            print("don't find profile")
        }
    }
    
    func saveProfileCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")

        do {
            let result = try managedContext.fetch(fetchRequest)
            var user: NSManagedObject!
            if result.count > 0 {
                user = (result[0] as! NSManagedObject)
            } else {
                let userEntity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
                user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            }
            
            user.setValue(self.profile.email, forKey: "email")
            user.setValue(self.profile.nickName, forKey: "name")
            user.setValue(self.profile.token, forKey: "token")
            
            try managedContext.save()
        } catch let error as NSError {
            self.loginState$.onNext(KakaoLoginState.logout)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteProfileCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = result[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
        } catch let error as NSError {
            self.loginState$.onNext(KakaoLoginState.logout)
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func setFinishNickName(nickname: String) {
        self.profile.nickName = nickname;
        self.saveProfileCoreData()
        self.loginState$.onNext(KakaoLoginState.login)
    }
}
