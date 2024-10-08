//
//  CoreData+Helpers.swift
//  Podcasts
//
//  Created by mert alp on 15.08.2024.
//

import Foundation
import CoreData
import UIKit

 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 let context = appDelegate.persistentContainer.viewContext
struct CoreDataController {
    static func addCoreData(model: PodcastCoreData, podcast: Podcast){
        model.feedUrl = podcast.feedUrl
        model.artworkUrl600 = podcast.artworkUrl600
        model.artistName = podcast.artistName
        model.trackName = podcast.trackName
        appDelegate.saveContext()
    }
    static func deleteCoreData(array: [PodcastCoreData], podcast: Podcast){
        let value = array.filter({$0.feedUrl == podcast.feedUrl})
        context.delete(value.first!)
        appDelegate.saveContext()
    }
    static func fetchCoreData(fetchRequest: NSFetchRequest<PodcastCoreData>, completion: @escaping([PodcastCoreData])->Void){
        do{
            let result = try context.fetch(fetchRequest)
            completion(result)
        }catch{
            
        }
    }
}
