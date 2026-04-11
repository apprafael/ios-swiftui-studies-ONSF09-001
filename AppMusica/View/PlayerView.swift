//
//  PlayerView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 11/04/26.
//

import Combine
import SwiftUI

struct PlayerView: View {
    var item: Music
    @StateObject var playerViewModel = PlayerViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2).opacity(0.8),
                    Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.6),
                    Color(red: 0.1, green: 0.6, blue: 0.8).opacity(0.4)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer(minLength: 20)
                
                AsyncImage(url: URL(string: item.artworkUrl100)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 10)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 250, height: 250)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 60))
                                .foregroundColor(.white.opacity(0.7))
                        )
                }
                
                VStack(spacing: 8) {
                    Text(item.trackName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(item.collectionName)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal)
                
                VStack(spacing: 8) {
                    ProgressView(value: playerViewModel.currentTime, total: playerViewModel.duration)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        .frame(height: 4)
                        .padding(.horizontal)
                    
                    HStack {
                        Text(playerViewModel.formatTime(playerViewModel.currentTime))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        Text(playerViewModel.formatTime(playerViewModel.duration))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal)
                }
                
                Button {
                    playerViewModel.setupPlayer(url: item.previewUrl)
                    playerViewModel.togglePlayPause()
                } label: {
                    Image(systemName: playerViewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 100, height: 100)
                        )
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding(.vertical, 40)
        }
    }
}
