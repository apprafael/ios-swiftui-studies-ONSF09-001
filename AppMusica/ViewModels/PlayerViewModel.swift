//
//  AppMusicaApp.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//
 
import Combine
import AVFoundation
 
final class PlayerViewModel: ObservableObject {
    
    // MARK: - Published States
    @Published var isPlaying: Bool = false
    @Published var currentURL: String?
    
    // MARK: - Player
    private(set) var player: AVPlayer?
    
    // MARK: - Setup
    func setupPlayer(url: String) {
        guard let url = URL(string: url) else { return }
        
        // Evita recriar o player se já for o mesmo áudio
        if currentURL == url.absoluteString {
            return
        }
        
        player = AVPlayer(url: url)
        currentURL = url.absoluteString
    }
    
    // MARK: - Controls
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        isPlaying ? pause() : play()
    }
    
    func stop() {
        player?.pause()
        player = nil
        currentURL = nil
        isPlaying = false
    }
    
    // Mark: - Observer
    private func observeEnd() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.isPlaying = false
        }
    }
}
