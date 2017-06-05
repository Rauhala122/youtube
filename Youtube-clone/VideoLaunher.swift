//
//  VideoLaunher.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 1.6.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//
import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var isPlaying = false
    
    var videoLauncher: VideoLauncher?
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activitySpinner: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()

    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.tintColor = .white
        button.isEnabled = true
        button.isHidden = true
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.maximumTrackTintColor = .white
        
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "dismissButton"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        isPlaying = false
        setGradientLayer()
        
        setVideoPlayer()
        setContainerView()
        setAcitivtySpinner()
        setPauseButton()
        setLengthLabel()
        setCurrenTimeLabel()
        setSlider()
        setCloseButton()
    }
    
    fileprivate func setGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    func handleDismiss() {
        videoLauncher?.dismissVideoLauncher()
    }
    
    func handleSliderChanged() {
        
        if let duration = player?.currentItem?.duration {
        
            let totalSeconds =  Float(CMTimeGetSeconds(duration))
            
            let value = slider.value * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            
            })
        }
    }
    
    func handlePause() {
        if isPlaying {
            pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            print("Pause pressed")
            player?.pause()
        } else if !isPlaying {
            pauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            player?.play()
            print("Play pressed")
        }
        isPlaying = !isPlaying
    }
    
    var player: AVPlayer?
    
    private func setVideoPlayer() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
            let interval = CMTime(value: 1, timescale: 2)
            
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // Move slider thumb
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.slider.value = Float(seconds / durationSeconds)
                }
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activitySpinner.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseButton.isHidden = false
            isPlaying = true
            
            
            if let duration = player?.currentItem?.duration {
                let seconds = Int(CMTimeGetSeconds(duration))
                let secondsText = seconds % 60
                
                let minutesText = String(format: "%02d", seconds / 60)
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    func setContainerView() {
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
    }
    
    func setAcitivtySpinner() {
        controlsContainerView.addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activitySpinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activitySpinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activitySpinner.startAnimating()
    }
    
    func setPauseButton() {
        
        addSubview(pauseButton)
        pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setLengthLabel() {
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setCurrenTimeLabel() {
        controlsContainerView.addSubview(currentTimeLabel)
        
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: videoLengthLabel.bottomAnchor).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setSlider() {
        addSubview(slider)
        slider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -8).isActive = true
        slider.bottomAnchor.constraint(equalTo: videoLengthLabel.bottomAnchor, constant: 2).isActive = true
        slider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 8).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setCloseButton() {
        addSubview(closeButton)
        closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
        let view = UIView()
    func showVideoPlayer() {
        print("Showing video player")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            view.backgroundColor = .white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 100, height: 50)
            


            let videoHeight = keyWindow.frame.width * 9 / 16
            let videoFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoHeight)
            let videoPlayerView = VideoPlayerView(frame: videoFrame)
            videoPlayerView.videoLauncher = self
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.frame = keyWindow.frame
            }, completion: { (completed) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
            }
        }
    
    func dismissVideoLauncher() {
        if let keyWindow = UIApplication.shared.keyWindow {
            
           UIView.animate(withDuration: 0.5, animations: { 
                self.view.frame = CGRect(x: keyWindow.frame.width - 340, y: keyWindow.frame.height - 240, width: 150, height: 75)
           })
        }
    }
}


