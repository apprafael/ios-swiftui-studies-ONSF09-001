//
//  AppState.swift
//  AppMusica
//
//  Created by Jessica Costa on 28/02/26.
//

import Combine
 
final class AppState: ObservableObject{
    enum Route {
        case login
        case home
    }
    
    @Published var route: Route = .login
}
