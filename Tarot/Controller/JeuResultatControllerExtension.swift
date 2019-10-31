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
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if let preneur = gj.preneur, let idx = gj.joueursEnMene.firstIndex(of: preneur) {
            pickerView.selectRow(idx, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
            gj.preneur = gj.joueursEnMene[0]
        }
        if let partenaire = gj.partenaire, let idx = gj.joueursEnMene.firstIndex(of: partenaire) {
            pickerView.selectRow(idx, inComponent: 1, animated: false)
        } else if numberOfComponents(in: pickerView) == 2 {
            pickerView.selectRow(0, inComponent: 1, animated: false)
            gj.partenaire = gj.joueursEnMene[0]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gj.joueursEnMene.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return gj.modeJeu != ModeJeu.simple ? 2 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dicoJoueurs[gj.joueursEnMene[row].idJoueur]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            gj.preneur = gj.joueursEnMene[row]
            let surnomDuPreneur = dicoJoueurs[gj.preneur!.idJoueur]
            print("Preneur choisi : \(surnomDuPreneur!)")
        }
        if component == 1 {
            gj.partenaire = gj.joueursEnMene[row]
            let surnomDuPpartenaire = dicoJoueurs[gj.partenaire!.idJoueur]
            print("Partenaire choisi : \(surnomDuPpartenaire!)")
        }
    }
    
}


