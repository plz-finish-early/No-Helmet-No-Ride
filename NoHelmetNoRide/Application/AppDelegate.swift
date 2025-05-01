//
//  AppDelegate.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/25/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerTestUserIfNeeded() // 테스트 함수
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // 테스트용 데이터 등록 함수
    
    private func registerTestUserIfNeeded() {
        let context = persistentContainer.viewContext
        
        // 기존 유저 초기화
        let users = try? context.fetch(AppUser.fetchRequest())
        users?.forEach { context.delete($0) }
        
        let kickboards = try? context.fetch(KickboardData.fetchRequest())
        kickboards?.forEach { context.delete($0) }
        
        do {
            try context.save()
        } catch {
            print("초기화 실패: \(error)")
        }
        
        CoreDataManager.shared.createAppUser(userID: "testUser", nickName: "홍길동", password: "1234")
        
        CoreDataManager.shared.createUserUsageInfo(
            userID: "testUser",
            kickboardID: "K001",
            usageDate: Date(),
            usageTime: 18.5,
            usageDistance: 2600,
            usageAmount: 1500
        )
        
        CoreDataManager.shared.createKickboardData(
            kickboardID: "K001",
            isRidingKickboard: true, 
            registrationDate: Date(),
            totalUsageTime: 18.5,
            totalUsageDistance: 2600,
            kickboardBatteryAmount: 87
        )
        
        print("테스트 유저 & 킥보드 등록 완료")
    }
}
