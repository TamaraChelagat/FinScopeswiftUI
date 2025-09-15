//
//  PodcastService.swift
//  FinScopeswiftUI
//
//  Created by Student1 on 17/06/2025.
//

import Foundation

struct PodcastEpisode: Identifiable, Codable {
    let id: UUID
    let title: String
    let showName: String
    let duration: String
    let description: String
    let localFileName: String
    let emoji: String
    
    init(id: UUID = UUID(),
         title: String,
         showName: String,
         duration: String,
         description: String,
         localFileName: String,
         emoji: String) {
        self.id = id
        self.title = title
        self.showName = showName
        self.duration = duration
        self.description = description
        self.localFileName = localFileName
        self.emoji = emoji
    }
}





