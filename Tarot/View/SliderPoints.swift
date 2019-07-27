//
//  SliderPoints.swift
//  Tarot
//
//  Created by Serge Gori on 15/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class SliderPoints: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }

    let step: Float = 1
    
    func changerValeur(_ valeur: Float) {
        super.setValue(valeur, animated: true)
    }
        //    override func setValue(_ value: Float, animated: Bool) {
//        if value > 45 {
//            self.minimumTrackTintColor = UIColor.red
//            self.maximumTrackTintColor = UIColor.green
//        } else {
//            self.minimumTrackTintColor = UIColor.green
//            self.maximumTrackTintColor = UIColor.red
//        }
//    }

    func miseEnPlace() {
        self.minimumValue = 0.0
        self.maximumValue = 91.0
        self.minimumTrackTintColor = UIColor.init(red: 22/255, green: 118/255, blue: 255/255, alpha: 1)
        self.maximumTrackTintColor = UIColor.init(red: 22/255, green: 118/255, blue: 255/255, alpha: 1)
//        layer.cornerRadius = 10
//        layer.borderWidth = 0.5
//        layer.borderColor = UIColor.darkGray.cgColor
//        tintColor = UIColor.black
//        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }

//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
//        if context.nextFocusedView == self {
//            backgroundColor = .red
//        } else if context.previouslyFocusedView == self {
//            backgroundColor = .clear
//        }
//        let valeur: Float = round(self.value)
//        super.setValue(valeur, animated: true)
//    }
    
}


