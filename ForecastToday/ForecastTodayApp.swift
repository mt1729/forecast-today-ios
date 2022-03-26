//
//  ForecastTodayApp.swift
//  ForecastToday
//
//  Created by Matthew Taylor on 3/18/22.
//
//

import SwiftUI

@main
struct ForecastTodayApp: App {
    let deps = DependencyGraph.new()

    init() {
        // Needed for InjectionIII (AppCode)
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(deps.homeVM)
        }
    }
}
