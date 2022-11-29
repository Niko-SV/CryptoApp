//
//  ContentView.swift
//  CryptoApp
//
//  Created by NikoS on 14.02.2022.
//

import SwiftUI

enum Tabs: String {
    case coins
    case favorites
    case profile
}

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var selectedTab: Tabs = .coins
    
    var body: some View {
        VStack {
            InternetConnectionIsNotAvailable()
            TabView(selection: $selectedTab) {
                CoinListView()
                    .tabItem { Label("Coins", systemImage: "bitcoinsign.circle") }
                    .tag(Tabs.coins)
                
                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "star") }
                    .tag(Tabs.favorites)
                
                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person") }
                    .tag(Tabs.profile)
            }
            .navigationTitle(selectedTab.rawValue.capitalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        authViewModel.signOut()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
