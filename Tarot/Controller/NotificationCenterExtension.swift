//
//  AjoutPersonneExtension.swift
//  Tarot
//
//  Created by Serge Gori on 19/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension AjoutPersonneController {
    
    func miseEnPlaceNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(clavierRentre), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clavierSort), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func clavierRentre(notification: Notification) {
        UIView.animate(withDuration: 0.35) {
            self.contrainteDuBas.constant = 0
        }
    }
    
    @objc func clavierSort(notification: Notification) {
        if let hauteur = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.35, animations: {
                self.contrainteDuBas.constant = -hauteur
            })
        }
    }
}
