//
//  AppDelegate.swift
//  Continuum
//
//  Created by DevMountain on 2/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //    checkAccountStatus
        
        return true
    }
    
    func checkAccountStatus(completion: @escaping(Result<Bool, UserError>) -> Void) {
        CKContainer.default().accountStatus { (status, error) in
            if let error = error {
                return completion(.failure(.noUserLoggedIn))
            } else {
                let tab
            }
        }
    }
        
}//End of class

