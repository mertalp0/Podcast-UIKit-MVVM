//
//  FavoriteCellViewModel.swift
//  Podcasts
//
//  Created by mert alp on 15.08.2024.
//

import Foundation

struct FavoriteCellViewModel {
    var podcastCoreData : PodcastCoreData!
    init(podcastCoreData: PodcastCoreData!) {
        self.podcastCoreData = podcastCoreData
    }
    var imageUrlPodcast : URL? {
        return URL(string: podcastCoreData.artworkUrl600 ?? "")
    }
    var podcastNameLabel : String? {
        return podcastCoreData.artistName
    }
    var podcastArtistNameLabel : String? {
        return podcastCoreData.trackName
    }
    
}
