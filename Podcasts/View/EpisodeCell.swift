//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by mert alp on 12.08.2024.
//

import UIKit

class EpisodeCell : UITableViewCell {
    //MARK: - Properties
    var episode : Episode? {
        didSet {configure()}
    }
    
    private let epidoseImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.numberOfLines = 2
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let pubDateLabel : UILabel = {
        let label = UILabel()
        label.text = "pubDateLabel"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let decriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "decriptionLabel"
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private var stackView : UIStackView!
   
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodeCell {
    private func setup(){
    
        configureUI()
    }
    private func configureUI(){
        epidoseImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(epidoseImageView)
        NSLayoutConstraint.activate([
            epidoseImageView.heightAnchor.constraint(equalToConstant: 100),epidoseImageView.widthAnchor.constraint(equalToConstant: 100),epidoseImageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 10),
            epidoseImageView.centerYAnchor.constraint(equalTo:centerYAnchor)
        ])
        stackView = UIStackView(arrangedSubviews: [pubDateLabel,titleLabel,decriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: epidoseImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: epidoseImageView.trailingAnchor , constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    }
    private func configure(){
        guard let episode = self.episode else {
            return
        }
        let viewModel = EpisodeCellViewModel(episode: episode)
        self.epidoseImageView.kf.setImage(with: viewModel.profileImageUrl)
        titleLabel.text = viewModel.title
        pubDateLabel.text = "pubDateLabel"
        decriptionLabel.text = viewModel.description
        
    }
    
    
}
