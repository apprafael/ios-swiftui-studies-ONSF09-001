//
//  FavoritesView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @Query var favoriteMusics: [Music]
    
    var body: some View {
        List {
            ForEach(favoriteMusics) { musicaFavorita in
                Text(musicaFavorita.trackName)
            }
            .onDelete { indexSet in
                if let index = indexSet.first {
                    let music = favoriteMusics[index]
                    deleteMusic(item: music)
                }
            }
        }
        .listStyle(.plain)
    }
    
    func deleteMusic(item: Music) {
        modelContext.delete(item)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
