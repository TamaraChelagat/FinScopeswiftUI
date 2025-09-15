import SwiftUI
import Foundation

struct PodcastDetailView: View {
    let episode: PodcastEpisode
    @StateObject var audioPlayerManager = AudioPlayerManager()



    var body: some View {
        VStack(spacing: 20) {
            Text(episode.emoji)
                .font(.system(size: 100))
                .padding(.top, 30)

            Text(episode.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(episode.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            PodcastPlayerCard(audioManager: audioPlayerManager, episode: episode)

//            Button(action: {
//                audioPlayerManager.playAudio(named: episode.localFileName)
//            }) {
//                Text("🎧 Play Episode")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.purple)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .alert("Audio Error", isPresented: $audioPlayerManager.showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(audioPlayerManager.errorMessage ?? "Unknown audio error")
        }
    }
}
