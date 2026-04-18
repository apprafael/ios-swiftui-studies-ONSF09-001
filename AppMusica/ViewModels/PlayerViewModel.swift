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
    @Published private(set) var duration: TimeInterval = 0.0
    @Published var currentTime: TimeInterval = 0.0
    @Published var isPlaying: Bool = false
    @Published var currentURL: String?
    @Published var currentMusicIndex: Int
    @Published var musics: [Music]
    @Published var selectedMusic: Music
    
    
    private var timeObserver: Any?
    
    // MARK: - Player
    private(set) var player: AVPlayer?
    
    init(currentMusicIndex: Int, musics: [Music]) {
        self.currentMusicIndex = currentMusicIndex
        self.musics = musics
        self.selectedMusic = musics[currentMusicIndex]
    }
    
    // MARK: - Setup
    func setupPlayer() {
        guard let url = URL(string: selectedMusic.previewUrl) else { return }
        
        // Evita recriar o player se já for o mesmo áudio
        if currentURL == url.absoluteString {
            return
        }
        
        player = AVPlayer(url: url)
        currentURL = url.absoluteString
        removePeriodicTimeObserver()
        addPeriodicTimeObserver()
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
    
    func seetTo() {
        player?.seek(to: CMTime(seconds: currentTime, preferredTimescale: 1000000))
    }
    
    // Mark: - Observer
    private func observeEnd() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] item in
            self?.isPlaying = false
        }
    }
    
    /// Adds an observer of the player timing.
    private func addPeriodicTimeObserver() {
        // Create a 0.5 second interval time.
        let interval = CMTime(value: 1, timescale: 2)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval,
                                                      queue: .main) { [weak self] time in
            guard let self else { return }
            // Update the published currentTime and duration values.
            currentTime = time.seconds
            duration = player?.currentItem?.duration.seconds ?? 0.0
            
            print("Timer: \(currentTime)")
            
            if currentTime == duration {
                playNextSong()
            }
        }
    }

    private func playNextSong() {
        currentMusicIndex = musics.index(after: currentMusicIndex)
        selectedMusic = musics[currentMusicIndex]
        removePeriodicTimeObserver()
        currentTime = 0.0
        setupPlayer()
        play()
    }

    /// Removes the time observer from the player.
    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        player?.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
    }
}
