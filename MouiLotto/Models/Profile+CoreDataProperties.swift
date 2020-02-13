//
//  Profile+CoreDataProperties.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/13.
//  Copyright © 2020 SungJu. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?

}
