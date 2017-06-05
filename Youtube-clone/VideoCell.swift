//
//  VideoCell.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 19.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            if let videoImage = video?.thumbnailImage {
                thumbnailImageView.sd_setImage(with: URL(string: videoImage))
            }
            
            
            if let profilImageName = video?.channel?.profileImage {
                profilImageView.sd_setImage(with: URL(string: profilImageName))
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            let subtitle = "\(video!.channel!.name!) • \(numberFormatter.string(from: video!.numberofVies!)!) • 3 years ago"
            subtitleLabel.text = subtitle
            
            if let videoTitle = video?.title {
                
                let size = CGSize(width: frame.width - 12 - 10 - 12 - 44 - 12 - 12, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                print(video?.title, estimatedRect.size.height)
                
                titleLabel.text = videoTitle
                
                if estimatedRect.size.height > 33 {
                 titleLabelHeightConst.constant = 44
                    
                } else {
                    titleLabelHeightConst.constant = 22
                }
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.alpha = 0.8
        return label
    }()
    
    let subtitleLabel: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .lightGray
        return tv
    }()
    
    
    var titleLabelHeightConst: NSLayoutConstraint!
        
   override func setupViews() {
        setupImageView()
        setupProfileImage()
        setupTitleLabel()
        setupSubtitle()
        setupSeperatorView()
        bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor).isActive = true
    }
    
    func setupImageView() {
        addSubview(thumbnailImageView)
        thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -24).isActive = true
    }
    
    func setupSeperatorView() {
        addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupProfileImage() {
        addSubview(profilImageView)
        profilImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor).isActive = true
        profilImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        profilImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profilImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: profilImageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: profilImageView.rightAnchor, constant: 10).isActive = true
        
        titleLabelHeightConst = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        titleLabelHeightConst.isActive = true
    }
    
    func setupSubtitle() {
        
        addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }        
}
