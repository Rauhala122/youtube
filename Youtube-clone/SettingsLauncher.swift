                                                                                                                                 //
//  SettingsLauncher.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 28.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
// Setting type enum

class SettingsLaunher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Homecontroller
    var homeController: HomeController?
    // Black view
    let blackView = UIView()
    // Setting cell height
    let cellHeight: CGFloat = 50
    
    // Settings array
    
    let settings: [Setting] = {
        
        let setting = Setting(name: .Setting, imageName: "settings")
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        let terms = Setting(name: .Terms, imageName: "privacy")
        let feedback = Setting(name: .Feedback, imageName: "feedback")
        let help = Setting(name: .Help, imageName: "help")
        let account = Setting(name: .SwitchAccount, imageName: "switch_account")
        
        return [setting, terms, feedback, help, account, cancelSetting]
    }()
    
    // Setting cell id
    let settingCell = "settingCell"
    
    
    // Make collection view to the settinglauncher
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // Show setting launcher function
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = cellHeight * CGFloat(settings.count)
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    // Dismiss setting launcher function
    func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if setting.name != .Cancel  {
               self.homeController?.showSettingViewController(setting: setting)
            } else {
                print("Else")
            }
        }
    }
    // Init the view
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: settingCell)
    }
    
    // Setting collectionview functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingCell", for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(setting: setting)
    }
}

