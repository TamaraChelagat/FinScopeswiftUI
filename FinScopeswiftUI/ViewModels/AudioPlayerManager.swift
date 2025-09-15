//
//  AudioPlayerManager.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 30/06/2025.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioPlayerManager: ObservableObject {
    @Published var player: AVAudioPlayer?
    @Published var errorMessage: String? = nil
    @Published var showingError: Bool = false

    func playAudio(named fileName: String) {
        let cleanedName = fileName.replacingOccurrences(of: ".mp3", with: "")
        guard let url = Bundle.main.url(forResource: cleanedName, withExtension: "mp3") else {
            errorMessage = "Audio file '\(fileName)' was not found in the app bundle."
            showingError = true
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            errorMessage = "Failed to play audio: \(error.localizedDescription)"
            showingError = true
        }
    }
    var isPlaying: Bool {
        player?.isPlaying ?? false
    }

    func togglePlayPause(named fileName: String) {
        if let player = player, player.isPlaying {
            player.pause()
        } else {
            playAudio(named: fileName)
        }
    }

    func skip(seconds: TimeInterval) {
        guard let player = player else { return }
        let newTime = max(0, player.currentTime + seconds)
        if newTime < player.duration {
            player.currentTime = newTime
            player.play()
        } else {
            player.stop()
        }
    }

}
