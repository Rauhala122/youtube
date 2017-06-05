//
//  SettingCell.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 29.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            settingLabel.textColor = isHighlighted ? .white : .black
            imageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            settingLabel.text = setting?.name?.rawValue
            imageView.image = UIImage(named: setting!.imageName!)?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .darkGray
        }
    }

    let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        setImageView()
        setupLabel()
    }
    
    func setImageView() {
        addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupLabel() {
        addSubview(settingLabel)
        settingLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    

    
    
    
}
