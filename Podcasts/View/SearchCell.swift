//
//  SearchCell.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import UIKit
import Kingfisher

class SearchCell : UITableViewCell {
    //MARK: - Proporties
    var result : Podcast? {
        didSet {configure()}
    }
    
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackName : UILabel = {
      let label = UILabel()
        label.text = "trackName"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let artistName : UILabel = {
      let label = UILabel()
        label.text = "artistName"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let trackCount : UILabel = {
      let label = UILabel()
        label.text = "trackCount"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var stackView: UIStackView!
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SearchCell {
    private func setup(){
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 12
        stackView = UIStackView(arrangedSubviews: [trackName , artistName, trackCount])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(photoImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.centerYAnchor.constraint(equalTo:centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo:  leadingAnchor , constant: 4 ),
            
            stackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant : 4 ),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    private func configure(){
        guard let result = self.result else {
            return
        }
        let viewModel = SearchViewModel(podcast: result)
        trackName.text = viewModel.artistName
        trackCount.text = viewModel.trackCountString
        artistName.text = viewModel.artistName
        photoImageView.kf.setImage(with: viewModel.photoImageUrl)
        
    }
}
