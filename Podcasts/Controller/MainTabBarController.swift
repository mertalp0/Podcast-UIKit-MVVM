//
//  MainTabBarController.swift
//  Podcasts
//
//  Created by mert alp on 11.08.2024.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .green
    }
}

//MARK: Helpers
extension MainTabBarController {
    private func setup(){
        viewControllers = [
        createViewController(rootViewController: FavoriteViewController(), title: "Favorites", imageName: "play.circle.fill"),
        createViewController(rootViewController: SearchViewController(), title:"Search" , imageName: "magnifyingglass"   ),
        createViewController(rootViewController: DownloadViewController(), title: "Download", imageName: "arrow.down.square")
        ]
    }
    private func createViewController(rootViewController: UIViewController , title: String , imageName: String)->UINavigationController {
        rootViewController.title = title
        let appearence = UINavigationBarAppearance()
        appearence.configureWithDefaultBackground()
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.compactAppearance = appearence
        controller.navigationBar.standardAppearance = appearence
        controller.navigationBar.scrollEdgeAppearance = appearence
        controller.navigationBar.compactScrollEdgeAppearance = appearence
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
        
    }
}
