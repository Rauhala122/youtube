//
//  Setting.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 29.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation

class Setting: NSObject {
    var name: SettingName?
    var imageName: String?
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
