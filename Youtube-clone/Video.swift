//
//  Video.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 19.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImage: String?
    var title: String?
    var numberofVies: NSNumber?
    var uploadedDate: Double?
    
    var channel: Channel?
    
    init(thumbnailImage1: String, title1: String, numberOfViews1: NSNumber, uploadedDate1: Double, channel1: Channel) {
        thumbnailImage = thumbnailImage1
        title = title1
        numberofVies = numberOfViews1
        uploadedDate = uploadedDate1
        channel = channel1
    }
}

