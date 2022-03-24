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
    let restApi: RestAPI
    let bkgQueue: DispatchQueue
    let urlSession: URLSession

    let homeVM: HomeVM
    let weatherRepo: WeatherRepository

    init() {
        // TODO: - Formation of dependencies here will get bloated over time. Move to separate StateObject(s)
        bkgQueue = DispatchQueue.global()
        urlSession = URLSession.shared
        restApi = ForecastTodayRestAPI(urlSession: urlSession)

        weatherRepo = WeatherRepository(dispatchQueue: bkgQueue, restAPI: restApi)
        homeVM = HomeVM(dispatchQueue: bkgQueue, weatherRepository: weatherRepo)

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
            ContentView().environmentObject(homeVM)
        }
    }
}
