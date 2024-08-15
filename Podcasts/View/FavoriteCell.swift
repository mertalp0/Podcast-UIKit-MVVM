//
//  FavoriteCell.swift
//  Podcasts
//
//  Created by mert alp on 14.08.2024.
//

import UIKit

class FavoriteCell : UICollectionViewCell {
    //MARK: - Properties
    var podcast : PodcastCoreData?{
        didSet{
            configure()
        }
    }
    
    private let podcastImageView : UIImageView = {
        let  image = UIImageView()
        image.customMode()
        image.backgroundColor = .lightGray
        return image
    }()
    private let podcastNameLabel : UILabel  = {
       let label = UILabel()
        label.text = "Podcast Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let podcastArtistNameLabel : UILabel  = {
       let label = UILabel()
        label.text = "Artist Name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

    private var fullStackView : UIStackView!
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Helpers

extension FavoriteCell {
    private func style(){
        fullStackView = UIStackView(arrangedSubviews: [podcastImageView,podcastNameLabel,podcastArtistNameLabel])
        fullStackView.axis = .vertical
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(fullStackView)
        NSLayoutConstraint.activate([
            podcastImageView.heightAnchor.constraint(equalTo: podcastImageView.widthAnchor),
            fullStackView.topAnchor.constraint(equalTo: topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    private func configure(){
        guard let podcastData = self.podcast else {
            return
        }
        let viewModel = FavoriteCellViewModel(podcastCoreData: podcastData)
        self.podcastArtistNameLabel.text = viewModel.podcastArtistNameLabel
        self.podcastNameLabel.text = viewModel.podcastNameLabel
        self.podcastImageView.kf.setImage(with: viewModel.imageUrlPodcast)

    }
    
    
}
