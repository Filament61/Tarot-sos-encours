//
//  PickerView.swift
//  Tarot
//
//  Created by Serge Gori on 08/10/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit


class PickerView: UIPickerView {

override init(frame: CGRect) {
    super.init(frame: frame)
    miseEnPlace()
}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        
    }
    
}
