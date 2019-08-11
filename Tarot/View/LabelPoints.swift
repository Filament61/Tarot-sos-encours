//
//  LabelPoints.swift
//  Tarot
//
//  Created by Serge Gori on 10/08/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class LabelPoints: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
//        if let nombre = Double(self.text!) {
//        self.textColor = nombre > 0.0 ? UIColor.blue : UIColor.red
//        }
        
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.darkGray.cgColor
//        tintColor = UIColor.blue
//        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }

    
    
}
