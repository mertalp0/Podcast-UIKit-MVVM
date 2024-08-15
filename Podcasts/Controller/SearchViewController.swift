//
//  SearchViewController.swift
//  Podcasts
//
//  Created by mert alp on 11.08.2024.
//

import UIKit
import Alamofire

private let reuseIdentifier = "SearchCell"

class SearchViewController: UITableViewController{
    //MARK: - Properties
    var searchResult : [Podcast] = []{
        //dizimize bir değer geldiğinde table view yenilenir
        didSet{ tableView.reloadData()}
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension SearchViewController {
    func style(){
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 130
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    func layout(){}
}

//MARK: - UItableViewDataSource
extension SearchViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.result = self.searchResult[indexPath.row]
        return cell
    }
}

//MARK: -UITableViewDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel ()
        label.text = "Search Start.."
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchResult.count == 0 ? 80 : 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = self.searchResult[indexPath.item ]
        let controller = EpisodeViewController(podcast: podcast)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        SearchService.fetchData(searchText: searchText ) {result  in
            self.searchResult = result
            print(result)
            
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchResult = []
    }
}


