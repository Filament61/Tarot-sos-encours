//
//  JeuResultatControllerExtension.swift
//  Tarot
//
//  Created by Serge Gori on 14/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension JeuResultatController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func miseEnPlacePicker() {
//        pickerViewAppele.delegate = self
//        pickerViewAppele.dataSource = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gj.joueursEnMene.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dicoJoueurs[Int(gj.joueursEnMene[row].idJoueur)]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let surnomDuPreneur = dicoJoueurs[Int(gj.joueursEnMene[row].idJoueur)]
            print("Preneur choisi : \(surnomDuPreneur!)")
        }
        if component == 1 {
            let surnomDuPpartenaire = dicoJoueurs[Int(gj.joueursEnMene[row].idJoueur)]
            print("Partenaire choisi : \(surnomDuPpartenaire!)")
        }
    }
}


