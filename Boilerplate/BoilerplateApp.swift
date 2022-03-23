//
//  BoilerplateApp.swift
//  Boilerplate
//
//  Created by Matthew Taylor on 3/18/22.
//
//

import SwiftUI

@main
struct BoilerplateApp: App {
    // Needed for InjectionIII (AppCode)
    init() {
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
            HomeView()
        }
    }
}
