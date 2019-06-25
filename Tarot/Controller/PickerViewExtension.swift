//
//  PickerViewExtension.swift
//  Tarot
//
//  Created by Serge Gori on 14/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension ScoreJeuController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func miseEnPlacePicker() {
        pickerViewAppele.delegate = self
        pickerViewAppele.dataSource = self
        
        pickerViewPreneur.delegate = self
        pickerViewPreneur.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return joueursTab.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return joueursTab[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //let nomDeLentreprise = joueursTab[row].nom ?? ""
        let nomDuPreneur = joueursTab[row]
        print("Ligne choisie: " + nomDuPreneur)
    }
}

extension UIPickerView {
    
}
