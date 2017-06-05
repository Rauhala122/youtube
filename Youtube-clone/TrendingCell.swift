//
//  TrendingCell.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 1.6.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchVideos(videoType: .Trending) { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
            
        }
     
    }
    
}
