//
//  Channel.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 28.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class Channel: NSObject {
    var name: String?
    var profileImage: String?
    init(name1: String, profileImage1: String) {
        name = name1
        profileImage = profileImage1
    }
}
