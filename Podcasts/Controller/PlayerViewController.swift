//
//  PlayerViewController.swift
//  Podcasts
//
//  Created by mert alp on 13.08.2024.
//

import UIKit
import AVKit

class PlayerViewController : UIViewController {
    //MARK: - Properties
    var episode : Episode
    private var mainStackView : UIStackView!
    private lazy var closeButton : UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName:"arrowshape.down"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)

        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.tintColor = .black
        
        return button
        
    }()
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 12
        return imageView
        
    }()
    
    private let sliderView:UISlider = {
       let sliderView = UISlider()
        sliderView.setThumbImage(UIImage(), for: .normal)
       return sliderView
        
    }()
    
    private let startLabel: UILabel = {
       let startLabel = UILabel()
        startLabel.text = "00 : 00"
        startLabel.textAlignment = .left
        return startLabel
        
    }()
    private let endLabel: UILabel = {
       let endLabel = UILabel()
        endLabel.text = "00 : 00"
        endLabel.textAlignment = .right
        return endLabel
        
    }()
    private var timerStackView : UIStackView!
    private let nameLabel: UILabel = {
       let podcastLabel = UILabel()
        podcastLabel.text = "name"
        podcastLabel.textAlignment = .center
        podcastLabel.numberOfLines = 2
        podcastLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return podcastLabel
        
    }()
    private let userLabel: UILabel = {
       let userLabel = UILabel()
        userLabel.text = "user"
        userLabel.textAlignment = .center
        return userLabel
        
    }()
    
    private var playStackView: UIStackView!
    private lazy var goForWardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName:"goforward" ), for: .normal)
        button.addTarget(self, action: #selector(handleGoForWardButton), for: .touchUpInside)

        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
        
    }()
    private lazy var goPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName:"play.fill" ), for: .normal)
        button.addTarget(self, action: #selector(handleGoPlay), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
        
    }()
    
    private lazy var goForBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName:"gobackward" ), for: .normal)
        button.addTarget(self, action: #selector(handleGoForBackButton), for: .touchUpInside)

        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
        
    }()
    private lazy var volumeSliderView:UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(handleVolumeSliderView), for: .valueChanged)
       
       return slider
    }()
    
    private var volumeStackView: UIStackView!
    
    private let minusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.minus.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.plus.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
   
    private let player :  AVPlayer = {
        let player = AVPlayer()
        return player
        
    }()
    
    //MARK: - Lifecycle
    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        startPlay()
        configureUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        player.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - Selectors
extension PlayerViewController {
    @objc private func handleGoPlay(_ sender: UIButton){
        if player.timeControlStatus == .paused {
            player.play()
            self.goPlayButton.setImage(UIImage(systemName:"play.fill" ), for: .normal)
        }
        else{
            player.pause()
            self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        }
    }
    @objc private func handleCloseButton(_ sender: UIButton){
        player.pause()
        self.dismiss(animated: true)
        
    }
    @objc private func handleGoForWardButton(_ sender: UIButton){
        updateForward(value: 30)
     
        
    }
    @objc private func handleGoForBackButton(_ sender: UIButton){
        updateForward(value: -15)
 
    }
    @objc private func handleVolumeSliderView(_ sender: UISlider){
        player.volume = sender.value
 
    }
    
}

//MARK: - Helpers
extension PlayerViewController {
    private func updateForward( value : Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(),exampleTime)
        player.seek(to: seekTime)
    }
    
    fileprivate func updateSlider(){
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.sliderView.value = Float(resultSecondTime)
    }
    fileprivate func updateTimeLabel(){
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
        }
    }
    
    private func startPlay() {
        guard let url = URL(string: episode.streamUrl) else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with:playerItem)
        player.play()
        self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.volumeSliderView.value = 0.4
        updateTimeLabel()
    }
    
    
    private func style(){
        view.backgroundColor = .white
        timerStackView = UIStackView(arrangedSubviews: [startLabel,endLabel])
        timerStackView.axis = .horizontal
        
        playStackView = UIStackView(arrangedSubviews: [UIView(),goForBackButton,UIView(),goPlayButton,UIView(),goForWardButton,UIView()])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        
        volumeStackView = UIStackView(arrangedSubviews: [minusImageView,volumeSliderView,plusImageView])
        volumeStackView.axis = .horizontal
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton,episodeImageView,sliderView,timerStackView,nameLabel,userLabel, playStackView,volumeStackView])
        
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalTo: view.widthAnchor , multiplier: 0.8),
            sliderView.heightAnchor.constraint(equalToConstant: 40),
            playStackView.heightAnchor.constraint(equalToConstant: 80),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32 ),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant:  -32 )
        ])
    }
    private func configureUI(){
        self.episodeImageView.kf.setImage(with: URL(string: episode.imageUrl))
        self.nameLabel.text = episode.title
        self.userLabel.text = episode.author
        
    }
}



