//
//  AppMusicaApp.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import SwiftUI
import SwiftData

@main
struct AppMusicaApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }.modelContainer(for: [UserAccount.self, Music.self])
    }
}
