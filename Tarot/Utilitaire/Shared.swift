//
//  Shared.swift
//  Tarot
//
//  Created by Serge Gori on 04/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit


class routine {

//    init(maDate date: Date) {
////                self.init()
//        self.maDate = date
//    }
    

    
//    var maDate: Date {
//        get {
//            return self.maDate
//        }
//        set {
//            self.maDate = newValue
//        }
//    }

    init() {
//        self.init()
        maDate = Date()
    }
    var maDate: Date 
    
    func formatDateHeure(monFormat format: String = "dd/MM/YYYY HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: maDate)
    }

//    @UserDefault(key: "isFirstBoot", defaultValue: false) var isFirstBoot: Bool
//    _isFirstBoot.reset()
    
//    var _isFirstBoot: UserDefault<Bool> = UserDefault<Bool>(key: "isFirstBoot", defaultValue: false)
//    var isFirstBoot: Bool {
//        get { return _isFirstBoot.wrappedValue }
//        set { _isFirstBoot.wrappedValue = newValue }
//    }
//    //////let toto = isFirstBoot
}

class IndicatorView: UIView {
    var color = UIColor.clear {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        UIBezierPath(ovalIn: rect).fill()
    }
    
}

//@propertyWrapper class UserDefault<T> {
//
//    init(key: String, defaultValue: T) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//
//    let key: String
//    let defaultValue: T
//
//    var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//}
//
//extension UserDefault {
//    func reset() {
//        wrappedValue = defaultValue
//    }
//}

