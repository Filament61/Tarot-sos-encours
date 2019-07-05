//
//  ImageArrondie.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class ImageArrondie: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace(Image img: UIImage = #imageLiteral(resourceName: "vador")) {
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        image = img
        contentMode = .scaleAspectFill
        clipsToBounds = true
        
    }
    
}
