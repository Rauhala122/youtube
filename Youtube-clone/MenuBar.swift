//
//  MenuBar.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 19.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    let cellId = "cellId"
    
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    var horizontalBarViewLeftAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        setupCollectionView()
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        let selected = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selected, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        setHorizontalBar()
    }
    // Set horizontal barView
    func setHorizontalBar() {
        let barView = UIView()
        barView.backgroundColor = .white
        barView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(barView)
        
        horizontalBarViewLeftAnchor = barView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarViewLeftAnchor.isActive = true
        
        barView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        barView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    // set up collectionview 
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    // Collectionview functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell {
            
            cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
            return cell
        }
        
        return UICollectionViewCell()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width / 4
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        homeController?.changeTitle(indexPath.item)
//        UIView.animate(withDuration: 0.3) {
////            self.horizontalBarViewLeftAnchor.constant = x
//            self.layoutIfNeeded()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


