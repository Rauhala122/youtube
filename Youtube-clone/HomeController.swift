//
//  ViewController.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 19.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    let trendingCellId = "trendingCellId"
    let subscriptionsCellId = "subscriptionsCellId"
    let cellId = "cellId"
    
    // Make setting launcher and menu bar
    lazy var settingsLauncher: SettingsLaunher = {
        let launcher = SettingsLaunher()
        launcher.homeController = self
        return launcher
    }()
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.homeController = self
        return menuBar
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "  Home"
        navigationController?.navigationBar.isTranslucent = false
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20) 
        navigationItem.titleView = titleLabel
        
        setupMenuBar()
        setupNavigationButtons()
        setupCollectionview()
    }

    
    // Setup collectionview
    func setupCollectionview() {
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
    }
    
    // Set navigation buttons to the navigation bar
    func setupNavigationButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let optionButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [optionButton, searchButton]
    }
    
    // Handle more when more button pressed
    func handleMore() {
        settingsLauncher.showSettings()
    }
    // Handle search button 
    func handleSearch() {
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let index = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: index as IndexPath, at: .right, animated: true)
        
    }
    
    // Present settingController when setttingcell tapped
    func showSettingViewController(setting: Setting) {
        let settingController = UIViewController()
        settingController.view.backgroundColor = .white
        settingController.navigationItem.title = setting.name?.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(settingController, animated: true)
    }

    // Set menubar bottom of the navigaiotn bar
    func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        view.addSubview(menuBar)
        
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: menuBar.topAnchor, constant: -20).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        redView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionsCellId
        } else  {
            identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarViewLeftAnchor.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = NSIndexPath(item: x, section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition:  UICollectionViewScrollPosition())
        
        changeTitle(x)
    }
    
    func changeTitle(_ index: Int) {
        titleLabel.text = "  \(titles[index])"
    }
    
}




