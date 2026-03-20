//
//  RootView.swift
//  AppMusica
//
//  Created by Jessica Costa on 28/02/26.
//

import SwiftUI
 
struct RootView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        NavigationStack {
            switch appState.route {
            case .login:
                AuthFlowView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
                
            case .home:
                HomeFlowView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
}
#Preview{
    RootView()
        .environmentObject(AppState())
}
