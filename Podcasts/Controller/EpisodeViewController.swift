//
//  EpidoseViewController.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import UIKit

private let reuseIdentifier  = "EpisodeCell"
class EpisodeViewController : UITableViewController {
    
    //MARK: -Properties
    private var podcast : Podcast
    
    
    private var episodeResult : [Episode] = []{
        didSet{
            self.tableView.reloadData()}
    }
    private var isFavorite = false {
        didSet{
            setupNavBarItem()
        }
    }
    private var resultCoreDataItems : [PodcastCoreData] = []{
        didSet{
               let isValue = resultCoreDataItems.contains(where: {$0.feedUrl == self.podcast.feedUrl})
               if isValue{
                   isFavorite = true
               }else{
                   isFavorite = false
               }
           }
    }
    //MARK: -Lifecycle
    init( podcast : Podcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}
//MARK: - Service
extension EpisodeViewController {
    fileprivate func fetchData(){
        EpisodeService.fetchData(urlString: self.podcast.feedUrl){result in
            DispatchQueue.main.async {
                self.episodeResult = result

            }
        }
    }
}
//MARK: - Selectors
extension EpisodeViewController {
    @objc private func handleFavoriButton(){
        print("Favori add")
        if isFavorite{
            deleteCoreData()
        }else{
            addCoreData()
        }
    }
}

//MARK: - Helpers
extension EpisodeViewController{
    private func addCoreData(){
        let model = PodcastCoreData(context: context)
        CoreDataController.addCoreData(model: model, podcast: self.podcast)
        self.isFavorite = true
        let window = UIApplication.shared.connectedScenes.first as!UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarController
        mainTabController.viewControllers?[0].tabBarItem.badgeValue = "new"
    }
    private func deleteCoreData(){
        CoreDataController.deleteCoreData(array: resultCoreDataItems, podcast: self.podcast)
        self.isFavorite = false
        

        
    }
    private func fetchCoreData(){
        let fetchRequest = PodcastCoreData.fetchRequest()
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { result in
            self.resultCoreDataItems = result
        }
    }
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupNavBarItem()
        fetchCoreData()
    }
    
    private func  setupNavBarItem(){
       
        if isFavorite{
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(.systemPink), style: .plain, target: self, action: #selector(handleFavoriButton))
            self.navigationItem.rightBarButtonItems = [navRightItem]
            
        }else{
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart")?.withTintColor(.systemPink), style: .plain, target: self, action: #selector(handleFavoriButton))
            self.navigationItem.rightBarButtonItems = [navRightItem]
        }
      

    }
}

//MARK: UITableViewDataSource
extension EpisodeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for:    indexPath) as! EpisodeCell
        cell.episode = self.episodeResult[indexPath.item]
        return cell
        
    }
}


//MARK: UITableViewDelegate
extension EpisodeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodeResult[indexPath.row]
        let controller = PlayerViewController(episode: episode)
        self.present(controller, animated: true)
        
    }
}
