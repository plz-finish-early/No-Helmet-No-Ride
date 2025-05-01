//
//  CoreDataManager.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/30/25.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Create

    /// 앱 사용자 등록
    func createAppUser(userID: String, nickName: String, password: String) {
        if fetchUser(userID: userID, password: password) != nil {
            print("이미 존재하는 사용자입니다.")
            return
        }
        let user = AppUser(context: context)
        user.userID = userID
        user.nickName = nickName
        user.password = password
        saveContext()
    }

    /// 킥보드 이용 정보 저장
    func createUserUsageInfo(userID: String, kickboardID: String, usageDate: Date, usageTime: Double, usageDistance: Int32, usageAmount: Int32) {
        let usageInfo = UserUsageInfo(context: context)
        usageInfo.userID = userID
        usageInfo.kickboardID = kickboardID
        usageInfo.usageDate = usageDate
        usageInfo.usageTime = usageTime
        usageInfo.usageDistance = usageDistance
        usageInfo.usageAmount = usageAmount
        saveContext()
    }

    /// 킥보드 등록
    func createKickboardData(kickboardID: String, isRidingKickboard: Bool, registrationDate: Date, totalUsageTime: Double, totalUsageDistance: Int32, kickboardBatteryAmount: Int16) {
        if isKickboardRegistered(kickboardID: kickboardID) {
            print("이미 등록된 킥보드입니다.")
            return
        }
        let kickboard = KickboardData(context: context)
        kickboard.kickboardID = kickboardID
        kickboard.isRidingKickboard = isRidingKickboard
        kickboard.registrationDate = registrationDate
        kickboard.totalUsageTime = totalUsageTime
        kickboard.totalUsageDistance = totalUsageDistance
        kickboard.kickboardBatteryAmount = kickboardBatteryAmount
        saveContext()
    }

    // MARK: - Read

    /// 로그인 시 유저 유효성 검사
    func fetchUser(userID: String, password: String) -> AppUser? {
        let request: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        request.predicate = NSPredicate(format: "userID == %@ AND password == %@", userID, password)
        do {
            return try context.fetch(request).first
        } catch {
            print("Login Fetch Failed: \(error)")
            return nil
        }
    }

    /// 이용 내역 조회
    func fetchUsageInfos(for userID: String) -> [UserUsageInfo] {
        let request: NSFetchRequest<UserUsageInfo> = UserUsageInfo.fetchRequest()
        request.predicate = NSPredicate(format: "userID == %@", userID)
        do {
            return try context.fetch(request)
        } catch {
            print("Filtered UsageInfo Fetch Failed: \(error)")
            return []
        }
    }

    /// 등록된 킥보드 전체 조회
    func fetchKickboardData() -> [KickboardData] {
        let request: NSFetchRequest<KickboardData> = KickboardData.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("KickboardData Fetch Failed: \(error)")
            return []
        }
    }

    /// 현재 대여중인 킥보드 조회
    func fetchInUseKickboards() -> [KickboardData] {
        let request: NSFetchRequest<KickboardData> = KickboardData.fetchRequest()
        request.predicate = NSPredicate(format: "isRidingKickboard == true")
        do {
            return try context.fetch(request)
        } catch {
            print("In-use Kickboard Fetch Failed: \(error)")
            return []
        }
    }

    /// 등록된 킥보드 중복 확인
    func isKickboardRegistered(kickboardID: String) -> Bool {
        let request: NSFetchRequest<KickboardData> = KickboardData.fetchRequest()
        request.predicate = NSPredicate(format: "kickboardID == %@", kickboardID)
        do {
            return try context.count(for: request) > 0
        } catch {
            return false
        }
    }

    // MARK: - Update

    /// 사용자 닉네임 수정
    func updateAppUser(user: AppUser, newNickname: String) {
        user.nickName = newNickname
        saveContext()
    }

    /// 배터리 잔량 수정
    func updateKickboardBattery(kickboard: KickboardData, newBattery: Int16) {
        kickboard.kickboardBatteryAmount = newBattery
        saveContext()
    }

    /// 유저가 킥보드를 대여했을 때 - 킥보드 ID 저장
    func assignKickboardToUser(user: AppUser, kickboardID: String) {
        user.kickboardID = kickboardID
        saveContext()
    }

    /// 킥보드 상태를 대여 중으로 설정
    func setKickboardInUse(kickboard: KickboardData) {
        kickboard.isRidingKickboard = true
        saveContext()
    }

    /// 킥보드 반납 후 상태/누적값 갱신
    func updateKickboardAfterUse(kickboard: KickboardData, addedTime: Double, addedDistance: Int32) {
        kickboard.isRidingKickboard = false
        kickboard.totalUsageTime += addedTime
        kickboard.totalUsageDistance += addedDistance
        saveContext()
    }

    /// 유저가 킥보드를 반납했을 때 - 킥보드 ID 제거
    func unassignKickboardFromUser(user: AppUser) {
        user.kickboardID = nil
        saveContext()
    }

    // MARK: - Delete

    func deleteAppUser(user: AppUser) {
        context.delete(user)
        saveContext()
    }

    func deleteUsageInfo(info: UserUsageInfo) {
        context.delete(info)
        saveContext()
    }

    func deleteKickboardData(kickboard: KickboardData) {
        context.delete(kickboard)
        saveContext()
    }

    // MARK: - Save

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save Failed: \(error)")
            }
        }
    }
}
