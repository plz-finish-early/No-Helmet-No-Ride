//
//  KickboardData+CoreDataProperties.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 5/2/25.
//
//

import Foundation
import CoreData


extension KickboardData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KickboardData> {
        return NSFetchRequest<KickboardData>(entityName: "KickboardData")
    }

    @NSManaged public var isRidingKickboard: Bool
    @NSManaged public var kickboardBatteryAmount: Double
    @NSManaged public var kickboardID: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var registrationDate: Date?
    @NSManaged public var totalUsageDistance: Int32
    @NSManaged public var totalUsageTime: Double
    @NSManaged public var userID: String?

}

extension KickboardData : Identifiable {

}
