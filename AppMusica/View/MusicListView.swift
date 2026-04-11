//
//  MusicListView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import Combine
import SwiftUI
import SwiftData
import AVFoundation

struct MusicListView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.modelContext) private var modelContext
    
    @State private var musics: [Music] = []
    @State private var isLoading = false
    @State private var searchText: String = ""
    @State private var hasSearched = false
    @State private var selectedItem: Music?
    
    @Query var favorites: [Music]
    
    var playerViewModel = PlayerViewModel()
    
    var body: some View {
        ZStack {
            contentView
        }
        .overlay {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.05)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.4)
                        
                        Text("Buscando músicas...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(24)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomSearchBar(searchText: $searchText)
                .background(.clear)
        }
        .task(id: searchText) {
            let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard !trimmed.isEmpty else {
                musics = []
                hasSearched = false
                isLoading = false
                return
            }
            
            do {
                try await Task.sleep(for: .milliseconds(500))
                await loadData(query: trimmed)
            } catch {
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !hasSearched {
            ContentUnavailableView(
                "Faça sua busca",
                systemImage: "magnifyingglass",
                description: Text("Pesquise por um artista, música ou álbum para ver os resultados.")
            )
        } else if hasSearched && musics.isEmpty && !isLoading {
            ContentUnavailableView(
                "Nenhum resultado encontrado",
                systemImage: "music.note.list",
                description: Text("Tente pesquisar outro artista ou música.")
            )
        } else {
            List(musics, id: \.trackId) { item in
                //Link(destination: URL(string: item.trackViewUrl)!) {
                    HStack {
                        AsyncImage(url: URL(string: item.artworkUrl30)) { image in
                            image
                        } placeholder: {
                            Image(systemName: "music.note")
                                .font(.title3)
                                .foregroundStyle(.blue)
                        }

                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.trackName)
                                .font(.headline)
                            
                            Text(item.collectionName)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .onTapGesture {
                            selectedItem = item
                        }
                        
                        Spacer()
                        
                        Button {
                            addFavorito(item: item)
                        } label: {
                            Image(systemName: favoriteButtonImageName(item: item) )
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                    
                //}
            }
            .listStyle(.plain)
            .sheet(item: $selectedItem) { item in
                AsyncImage(url: URL(string: item.artworkUrl100))
                
                Button("Play") {
                    playerViewModel.setupPlayer(url: item.previewUrl)
                    playerViewModel.play()
                }
                
                Button("Pause") {
                    playerViewModel.pause()
                }
            }
        }
    }
    
    func addFavorito(item: Music) {
        
        if let favoriteMusic = isMusicFavorite(item: item) {
            modelContext.delete(favoriteMusic)
        } else {
            modelContext.insert(item)
        }

        do {
            try modelContext.save()

            // garantir que botao fique selecionado
        } catch {
            // garantir que botao fique nao selecionado
        }
    }
    
    func isMusicFavorite(item: Music) -> Music? {
        favorites.first(where: { music in music.trackId == item.trackId })
    }
    
    func favoriteButtonImageName(item: Music) -> String {
        /*return*/ isMusicFavorite(item: item) != nil ? "heart.fill" : "heart"
    }
    
    func loadData(query: String) async {
        isLoading = true
        hasSearched = true
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(encodedQuery)&entity=song") else {
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(MusicResponse.self, from: data)
            musics = decodedResponse.results
        } catch {
            musics = []
            print("Erro ao buscar músicas: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        MusicListView()
    }
}
