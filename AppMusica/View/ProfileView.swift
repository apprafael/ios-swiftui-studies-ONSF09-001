//
//  ProfileView.swift
//  AppMusica
//
//  Created by Jessica Costa on 27/02/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ZStack {
            Text("Profile")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ProfileView()
    }
}
