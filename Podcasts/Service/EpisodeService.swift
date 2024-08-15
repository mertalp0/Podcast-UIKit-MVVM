//
//  EpisodeSercive.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import Foundation
import FeedKit

struct EpisodeService{
    static func fetchData(urlString : String, compeliton:@escaping([Episode])->Void){
        var episodeResult : [Episode] = []
        let feedKit = FeedParser(URL: URL(string:   urlString)!)
        feedKit.parseAsync { result in
            switch result{
            case .success(let feed):
                switch feed{
                case.atom(_):
                    break
                case.json(_):
                    break
                case.rss(let feedResult):
                    feedResult.items?.forEach({value in
                      let episodeCell = Episode(value: value)
                        episodeResult.append(episodeCell)
                        compeliton(episodeResult)
                    })
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}
