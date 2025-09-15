import SwiftUI
import Foundation

struct PodcastView: View {
    
    let episodes: [PodcastEpisode] = Bundle.main.decode("Podcasts.json")
    
    var body: some View {
        NavigationStack {
            List(episodes) { episode in
                NavigationLink {
                    PodcastDetailView(episode: episode)
                } label: {
                    PodcastEpisodeRow(episode: episode)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color(.systemGroupedBackground))
            }
            .listStyle(.plain)
            .listRowSpacing(12)
            .navigationTitle("Podcasts")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct PodcastEpisodeRow: View {
    var episode: PodcastEpisode
    
    var body: some View {
        HStack(spacing: 12) {
            
            Text(episode.emoji)
                .font(.system(size: 50)) // adjust size if desired
                .frame(width: 80, height: 80)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(episode.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(episode.showName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(episode.duration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }

}

#Preview {
    PodcastView()
}
