//
//  BaseCell.swift
//  Youtube-clone
//
//  Created by Saska Rauhala on 19.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}
