//
//  KickboardData+CoreDataProperties.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/30/25.
//
//

import Foundation
import CoreData


extension KickboardData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KickboardData> {
        return NSFetchRequest<KickboardData>(entityName: "KickboardData")
    }

    @NSManaged public var kickboardID: String?
    @NSManaged public var isRidingKickboard: Bool
    @NSManaged public var registrationDate: Date?
    @NSManaged public var totalUsageTime: Double
    @NSManaged public var totalUsageDistance: Int32
    @NSManaged public var kickboardBatteryAmount: Int16

}

extension KickboardData : Identifiable {

}
