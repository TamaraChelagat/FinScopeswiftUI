//
//  PodcastPlayerCardView.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 01/07/2025.
//

import Foundation
import SwiftUI

struct PodcastPlayerCard: View {
    @ObservedObject var audioManager: AudioPlayerManager
    var episode: PodcastEpisode
    
    var body: some View {
        VStack(spacing: 12) {
            Text(episode.emoji)
                .font(.system(size: 40))
            
            Text(episode.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
            
            HStack {
                Button(action: {
                    audioManager.skip(seconds: -15)
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.title2)
                }
                
                Button(action: {
                    audioManager.togglePlayPause(named: episode.localFileName)
                })
                {
                    Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                }
                
                Button(action: {
                    audioManager.skip(seconds: 15)
                }) {
                    Image(systemName: "goforward.15")
                        .font(.title2)
                }
            }
            .foregroundColor(.primary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

