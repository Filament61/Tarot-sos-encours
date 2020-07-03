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

extension JeuResultatController {
    
    func miseEnPlaceForEditing() {
        
        guard let jeu = JeuResultat.jeuResultat(idJeux: [indexJeu.selected]).last else { return }
        
        // Nombre de bouts
        segmentNbBout.selectedSegmentIndex = Int(jeu.nbBout)
        
        // Petit au bout
        switch jeu.petitAuBout {
        case -1:
            switchPetitAuBoutAttaque.setOn(false, animated: true)
            switchPetitAuBoutAttaque.isEnabled = true
            switchPetitAuBoutDefense.setOn(true, animated: true)
            switchPetitAuBoutDefense.isEnabled = true
        case 0:
            switchPetitAuBoutAttaque.setOn(false, animated: true)
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.setOn(false, animated: true)
            switchPetitAuBoutDefense.isEnabled = false
        case 1:
            switchPetitAuBoutAttaque.setOn(true, animated: true)
            switchPetitAuBoutAttaque.isEnabled = true
            switchPetitAuBoutDefense.setOn(false, animated: true)
            switchPetitAuBoutDefense.isEnabled = true
        default:
            break
        }
    
        // Poignée
        switch jeu.poignee {
        case -3 ... -1:
            switchPoigneeAttaque.setOn(false, animated: true)
            switchPoigneeAttaque.isEnabled = true
            switchPoigneeDefense.setOn(true, animated: true)
            switchPoigneeDefense.isEnabled = true
            segmentPoignee.selectedSegmentIndex = abs(Int(jeu.poignee)) - 1
        case 0:
            switchPoigneeAttaque.setOn(false, animated: true)
            switchPoigneeAttaque.isEnabled = false
            switchPoigneeDefense.setOn(false, animated: true)
            switchPoigneeDefense.isEnabled = false
        case 1 ... 3:
            switchPoigneeAttaque.setOn(true, animated: true)
            switchPoigneeAttaque.isEnabled = true
            switchPoigneeDefense.setOn(false, animated: true)
            switchPoigneeDefense.isEnabled = true
            segmentPoignee.selectedSegmentIndex = abs(Int(jeu.poignee)) - 1
        default:
            break
        }
        
        // Chelem
        switch jeu.chelem {
        case -3 ... -1:
            switchChelemAttaque.setOn(false, animated: true)
            switchChelemAttaque.isEnabled = true
            switchChelemDefense.setOn(true, animated: true)
            switchChelemDefense.isEnabled = true
            segmentChelem.selectedSegmentIndex = abs(Int(jeu.chelem)) - 1
        case 0:
            switchChelemAttaque.setOn(false, animated: true)
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.setOn(false, animated: true)
            switchChelemDefense.isEnabled = false
        case 1 ... 3:
            switchChelemAttaque.setOn(true, animated: true)
            switchChelemAttaque.isEnabled = true
            switchChelemDefense.setOn(false, animated: true)
            switchChelemDefense.isEnabled = true
            segmentChelem.selectedSegmentIndex = abs(Int(jeu.chelem)) - 1
        default:
            break
        }
        

    
    
    }
}


