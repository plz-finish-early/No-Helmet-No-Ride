//
//  UserUsageInfo+CoreDataProperties.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/30/25.
//
//

import Foundation
import CoreData


extension UserUsageInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserUsageInfo> {
        return NSFetchRequest<UserUsageInfo>(entityName: "UserUsageInfo")
    }

    @NSManaged public var userID: String?
    @NSManaged public var kickboardID: String?
    @NSManaged public var usageDate: Date?
    @NSManaged public var usageTime: Double
    @NSManaged public var usageDistance: Int32
    @NSManaged public var usageAmount: Int32

}

extension UserUsageInfo : Identifiable {

}
