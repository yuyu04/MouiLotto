//
//  AppDelegate.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    var profileSelectionViewController: UIViewController?
    
    let loginViewModel = KakaoLoginViewModel()
    var loginState = KakaoLoginState.logout
    
    var disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.loginViewModel.loginState$
            .map( {$0} )
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { loginState in
                self.loginState = loginState
                self.reloadRootViewController()
            }, onError: { error in
                UIAlertController.showMessage(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
        
        setupEntryController()
        reloadRootViewController()
        
        return true
    }
    
    // MARK: custom functions
    fileprivate func setupEntryController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let navigationController2 = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let navigationController3 = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        viewController.loginViewModel = self.loginViewModel
        navigationController.pushViewController(viewController, animated: true)
        self.loginViewController = navigationController
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
        navigationController2.pushViewController(viewController2, animated: true)
        self.mainViewController = navigationController2
        
        let viewController3 = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileSelectionViewController
        viewController3.loginViewModel = self.loginViewModel
        navigationController3.pushViewController(viewController3, animated: true)
        self.profileSelectionViewController = navigationController3
    }
    
    fileprivate func reloadRootViewController() {
        switch self.loginState {
        case .login:
            self.window?.rootViewController = self.mainViewController
            break
        case .selectionProfile:
            self.window?.rootViewController = self.profileSelectionViewController
            break
        default:
            self.window?.rootViewController = self.loginViewController
        }
        
        self.window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        //MapleBaconStorage.sharedStorage.clearMemoryStorage()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MouiLotto")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

