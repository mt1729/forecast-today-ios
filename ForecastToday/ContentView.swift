//
//  ContentView.swift
//  ForecastToday
//
//  Created by Matthew Taylor on 3/18/22.
//
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var homeVM: HomeVM

    var body: some View {
        HomeView().environmentObject(homeVM)
    }
}

class ContentView_Previews: PreviewProvider {
    static let deps = DependencyGraph.new()

    static var previews: some View {
        // To update preview with a state, mutate via VM functions
        ContentView().environmentObject(deps.homeVM)
    }

    // Needed for InjectionIII (AppCode)
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView_Previews.previews)
    }
    #endif
}
