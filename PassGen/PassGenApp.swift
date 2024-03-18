//
//  PassGenApp.swift
//  PassGen
//

//Code that initializes app (created by Xcode)
import SwiftUI

@main
struct PassGenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}
