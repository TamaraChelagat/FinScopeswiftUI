//
//  HomeView.swift
//  FinScopeswiftUI
//
//  Created by Student1 on 17/06/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeDashboardView()
                .tabItem { Label("Home", systemImage: "house") }
            PodcastView()
                .tabItem { Label("Podcasts", systemImage: "mic.fill") }
            DailyTipView()
                .tabItem { Label("Tips", systemImage: "lightbulb") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }

        }
        
    }
}
