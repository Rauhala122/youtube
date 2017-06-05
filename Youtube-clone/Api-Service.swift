//
//  Api-Service.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire 
class ApiService: NSObject {
    
    
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(videoType: VideoType, completion: @escaping ([Video]) -> ()) {
        
        var videos = [Video]()
        
        Alamofire.request("https://s3-us-west-2.amazonaws.com/youtubeassets/\(videoType.rawValue).json").responseJSON { (response) in
            if let youtubrVideos = response.value as? [Dictionary<String, AnyObject>] {
                for video in youtubrVideos {
                    var currentChannel: Channel?
                    if let channel = video["channel"] as? Dictionary<String, AnyObject> {
                        if let name = channel["name"] as? String {
                            if let profileImageName = channel["profile_image_name"] as? String {
                                currentChannel = Channel(name1: name, profileImage1: profileImageName)
                                
                            }
                        }
                        if let title = video["title"] as? String {
                            if let videoImageName = video["thumbnail_image_name"] as? String {
                                if let numberOfViews = video["number_of_views"] as? NSNumber {
                                    let video = Video(thumbnailImage1: videoImageName, title1: title, numberOfViews1: numberOfViews, uploadedDate1: 10.3, channel1: currentChannel!)
                                    videos.append(video)
                                }
                            }
                        }
                    }
                }
                completion(videos)
            }
        }
    }
}
