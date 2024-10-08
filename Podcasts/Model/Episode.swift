//
//  Episode.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import Foundation
import FeedKit

struct Episode : Codable{
    let title : String
    let pubDate : Date
    let description : String
    let imageUrl : String
    let streamUrl : String
    let author : String
    
    init(value : RSSFeedItem) {
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.description = value.iTunes?.iTunesSubtitle ?? value.description ?? ""
        self.imageUrl = value.iTunes?.iTunesImage?.attributes?.href ?? "https://cdn.pixabay.com/photo/2018/09/23/00/09/podcast-3696504_1280.jpg"
        self.streamUrl = value.enclosure?.attributes?.url ?? ""
        self.author = value.iTunes?.iTunesAuthor?.description ?? value.author ?? ""
    }
    
    
}
