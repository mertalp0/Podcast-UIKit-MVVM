//
//  EpisodeCellViewModel.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import Foundation
struct EpisodeCellViewModel{
    let episode : Episode!
    init(episode: Episode!) {
        self.episode = episode
    }
    var profileImageUrl :URL?{
        return URL(string: episode.imageUrl)
    }
    var title :String? {
        return episode.title
    }
    var description :String? {
        return episode.description
    }
    
}
