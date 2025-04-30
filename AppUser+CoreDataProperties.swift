//
//  AppUser+CoreDataProperties.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/30/25.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var userID: String?
    @NSManaged public var nickName: String?
    @NSManaged public var password: String?
    @NSManaged public var kickboardID: String?

}

extension AppUser : Identifiable {

}
