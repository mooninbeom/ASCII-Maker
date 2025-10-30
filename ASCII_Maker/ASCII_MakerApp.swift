//
//  ASCII_MakerApp.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/14/25.
//

import SwiftUI

@main
struct ASCII_MakerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
