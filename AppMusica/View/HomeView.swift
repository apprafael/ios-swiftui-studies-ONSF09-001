//
//  HomeView.swift
//  AppMusica
//
//  Created by Jessica Costa on 27/02/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            MusicListView()
                .tabItem {
                    Label("Músicas", systemImage: "list.dash")
                }
                .tag(0)

            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }
                .tag(1)

            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
                .tag(2)
        }
        .navigationTitle(titleForTab())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Sair") {
                    logout()
                }
            }
        }
    }
    
    private func titleForTab() -> String {
        switch selectedTab {
        case 0:
            return "Músicas"
        case 1:
            return "Favoritos"
        case 2:
            return "Perfil"
        default:
            return "Home"
        }
    }
    
    private func logout() {
        withAnimation(.snappy) {
            appState.route = .login
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
    }
}
