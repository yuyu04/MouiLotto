//
//  Profile+Extension.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/14.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import CoreData

func == (lhs: Profile, rhs: Profile) -> Bool {
    return lhs.email == rhs.email
}

extension Profile : Equatable { }

extension Profile : Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "Profile"
    }
    
    static var primaryAttributeName: String {
        return "email"
    }
    
    init(entity: T) {
        email = entity.value(forKey: "email") as! String
        nickName = entity.value(forKey: "nickname") as! String
        token = entity.value(forKey: "token") as! String
    }
    
    func update(_ entity: T) {
        entity.setValue(email, forKey: "email")
        entity.setValue(nickName, forKey: "nickname")
        entity.setValue(token, forKey: "token")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
