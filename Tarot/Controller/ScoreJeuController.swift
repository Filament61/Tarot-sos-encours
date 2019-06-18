//
//  ScoreJeuController.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class ScoreJeuController: UIViewController {
    
    
    @IBOutlet weak var pickerViewPreneur: UIPickerView!
    @IBOutlet weak var pickerViewAppele: UIPickerView!
    @IBOutlet weak var segmentContrat: UISegmentedControl!
    @IBOutlet weak var segmentNbBout: UISegmentedControl!
    @IBOutlet weak var switchPetitAuBoutAttaque: UISwitch!
    @IBOutlet weak var switchPetitAuBoutDefense: UISwitch!
    @IBOutlet weak var switchPoigneeAttaque: UISwitch!
    @IBOutlet weak var switchPoigneeDefense: UISwitch!
    @IBOutlet weak var segmentPoignee: UISegmentedControl!
    @IBOutlet weak var switchChelemAttaque: UISwitch!
    @IBOutlet weak var switchChelemDefense: UISwitch!
    @IBOutlet weak var labelGain: UILabel!
    @IBOutlet weak var labelPointsAttaque: UILabel!
    @IBOutlet weak var labelPointsDefense: UILabel!
    @IBOutlet weak var labelPointsBase: UILabel!
    @IBOutlet weak var sliderPoints: SliderPoints!
    
    @IBOutlet weak var labelPointsGain: UILabel!
    @IBOutlet weak var labelPointsSousTotal: UILabel!
    @IBOutlet weak var labelPointsPetitAuBout: UILabel!
    @IBOutlet weak var labelPointsPoignee: UILabel!
    @IBOutlet weak var labelPointsChelem: UILabel!
    @IBOutlet weak var labelContrat: UILabel!
    
    @IBOutlet weak var labelPointsTotaux: UILabel!
    
    
    let texteVierge = " "
    var scoreJeu = JeuComplet()

    override func viewDidLoad() {
        super.viewDidLoad()
        //miseEnPlaceImagePicker()
        miseEnPlacePicker()
        //miseEnPlaceTextField()
        //miseEnPlaceNotification()
        //fetchEntreprises()
        miseEnPlace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //largeurContrainte.constant = view.frame.width
        //scroll.contentSize = CGSize(width: largeurContrainte.constant, height: scroll.frame.height)
    }

    
    
    func calculerPointsPetitAuBout(attaque: Bool, defense: Bool) {
        if !attaque && !defense || attaque && defense {
            scoreJeu.petitAuBout = 0
        }
        if attaque {
            scoreJeu.petitAuBout = 1
        }
        if defense {
            scoreJeu.petitAuBout = -1
        }
    }
    
    func calculerPointsPoignée(attaque: Bool, defense: Bool, choixPoignee: Int) {
        if !attaque && !defense || attaque && defense {
            scoreJeu.poignee = 0
        }
        if attaque {
            scoreJeu.poignee = abs(choixPoignee + 1)
        }
        if defense {
            scoreJeu.poignee = -abs(choixPoignee + 1)
        }
    }
    func calculerPointsChelem(attaque: Bool, defense: Bool) {
        if !attaque && !defense || attaque && defense {
            scoreJeu.chelem = 0
        }
        if attaque {
            scoreJeu.chelem = 1
        }
        if defense {
            scoreJeu.chelem = -1
        }
    }
    

    
    func majScore() {
        // label score GAIN
        if scoreJeu.gain! != scoreJeu.nbPointsMaxi && scoreJeu.pointsFaits >= Float(0) {
            if scoreJeu.isReussi ?? false {
                labelGain.textColor = UIColor.init(red: 10/255, green: 200/255, blue: 30/255, alpha: 1)
            } else {
                labelGain.textColor = UIColor.init(red: 200/255, green: 10/255, blue: 60/255, alpha: 1)
            }
            labelGain.text = String(scoreJeu.gain!)
        }
        
        
        // label points : GAIN
        if scoreJeu.gain! != scoreJeu.nbPointsMaxi && scoreJeu.pointsFaits >= Float(0) {
            labelPointsGain.text = String(scoreJeu.gain!)
        } else {
            labelPointsGain.text = texteVierge
        }
        
        
        // label points : BASE CONTRAT
        if scoreJeu.contrat > 0 {
            if scoreJeu.isReussi ?? true {
                labelPointsBase.text = String(scoreJeu.baseContrat)
            } else {
                labelPointsBase.text = "-" + String(scoreJeu.baseContrat)
            }
        } else {
            labelPointsBase.text = texteVierge
        }
        
        
        // label points : POINTS
        if scoreJeu.pointsFaits >= Float(0) {
            labelPointsAttaque.text = String(scoreJeu.pointsFaits)
            labelPointsDefense.text = String(scoreJeu.nbPointsMaxi - scoreJeu.pointsFaits)
        }

        
        // label points : SOUS-TOTAL
        if scoreJeu.gain! != scoreJeu.nbPointsMaxi && scoreJeu.pointsFaits >= Float(0) && scoreJeu.nbBout > 0 && scoreJeu.contrat > 0 {
            var st: Float
            if scoreJeu.isReussi ?? false {
                st = scoreJeu.baseContrat + (scoreJeu.gain ?? 0.0) + scoreJeu.pointsPetitAuBout
            } else {
                st = -(scoreJeu.baseContrat - (scoreJeu.gain ?? 0.0) - scoreJeu.pointsPetitAuBout)
            }
            labelPointsSousTotal.text = String(Int(scoreJeu.coef!)) + " x " + String(st)
        } else {
            labelPointsSousTotal.text = texteVierge
        }


        // label points : PETIT AU BOUT
        if scoreJeu.pointsPetitAuBout != Float(0) {
            if scoreJeu.pointsPetitAuBout < Float(0) {
                labelPointsPetitAuBout.text = "(Défense)  " + String(scoreJeu.pointsPetitAuBout)
            } else {
                labelPointsPetitAuBout.text = String(scoreJeu.pointsPetitAuBout)
            }
        } else {
            labelPointsPetitAuBout.text = texteVierge
        }
        
        
        // label points : POIGNEE
        if scoreJeu.pointsPoignee == Float(0) {
            labelPointsPoignee.text = texteVierge
        } else {
            labelPointsPoignee.text = ""
            if scoreJeu.pointsPoignee < Float(0) {
                labelPointsPoignee.text = "(Défense)  "
            }
            if !(scoreJeu.isReussi ?? false) {
                labelPointsPoignee.text = labelPointsPoignee.text! + " -"
            }
            labelPointsPoignee.text = labelPointsPoignee.text! + String(abs(scoreJeu.pointsPoignee))
        }
        
        
        // label points : CHELEM
        labelPointsChelem.text = " "
        
        
        // label points : TOTAL
        if scoreJeu.gain! != scoreJeu.nbPointsMaxi && scoreJeu.pointsFaits >= Float(0) && scoreJeu.nbBout > 0 && scoreJeu.contrat > 0 {
            labelPointsTotaux.text = String(scoreJeu.total!)
        } else {
            labelPointsTotaux.text = texteVierge
        }

        
    }
    
    func miseEnPlace() {
        //scoreJeu.pointsFaits = sliderPoints.value
        majScore()
    }
    
    
//  MARK: IBActions
    
    //
    //              Options Contrats
    //
    @IBAction func selectionnerContrat(_ sender: UISegmentedControl) {
        scoreJeu.contrat = sender.selectedSegmentIndex + 1
        // Calcul et mise à jour affichage
        majScore()
    }
    
    //
    //              Options Nombre de Bout
    //
    @IBAction func selectionnerNbBout(_ sender: UISegmentedControl) {
        scoreJeu.nbBout = sender.selectedSegmentIndex
        // Calcul et mise à jour affichage
        majScore()
    }
    
    
    //
    //              Options Petit au bout
    //
    @IBAction func changerSwitchPetitAuBoutAttaque(_ sender: UISwitch) {
        if switchPetitAuBoutAttaque.isOn == false && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.isEnabled = false
        }
        switchPetitAuBoutDefense.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
        majScore()

    }
    
    @IBAction func changerSwitchPetitAuBoutDefense(_ sender: UISwitch) {
        if switchPetitAuBoutAttaque.isOn == false && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.isEnabled = false
        }
        switchPetitAuBoutAttaque.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
        majScore()

    }
    
    @IBAction func selectionnerPetitAuBout(_ sender: UIButton) {
        if switchPetitAuBoutAttaque.isOn == false && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.setOn(true, animated: true)
            switchPetitAuBoutAttaque.isEnabled = true
            switchPetitAuBoutDefense.setOn(false, animated: true)
            switchPetitAuBoutDefense.isEnabled = true
        } else if switchPetitAuBoutAttaque.isOn == true && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.setOn(false, animated: true)
            switchPetitAuBoutAttaque.isEnabled = true
            switchPetitAuBoutDefense.setOn(true, animated: true)
            switchPetitAuBoutDefense.isEnabled = true
        } else {
            switchPetitAuBoutAttaque.setOn(false, animated: true)
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.setOn(false, animated: true)
            switchPetitAuBoutDefense.isEnabled = false
        }
        // Calcul et mise à jour affichage
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
        majScore()

    }
    
    //
    //              Options Poignée
    //
    @IBAction func changerSwitchPoigneeAttaque(_ sender: UISwitch) {
        if switchPoigneeAttaque.isOn == false && switchPoigneeDefense.isOn == false {
            segmentPoignee.selectedSegmentIndex = UISegmentedControl.noSegment
            switchPoigneeAttaque.isEnabled = false
            switchPoigneeDefense.isEnabled = false
        }
        switchPoigneeDefense.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
        majScore()
    }

    @IBAction func changerSwitchPoigneeDefense(_ sender: UISwitch) {
        if switchPoigneeAttaque.isOn == false && switchPoigneeDefense.isOn == false {
            segmentPoignee.selectedSegmentIndex = UISegmentedControl.noSegment
            switchPoigneeAttaque.isEnabled = false
            switchPoigneeDefense.isEnabled = false
        }
        switchPoigneeAttaque.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
        majScore()
    }

    @IBAction func selectionnerSegmentPoignee(_ sender: UISegmentedControl) {
        if switchPoigneeAttaque.isOn == false && switchPoigneeDefense.isOn == false {
            switchPoigneeAttaque.setOn(true, animated: true)
            switchPoigneeAttaque.isEnabled = true
            switchPoigneeDefense.setOn(false, animated: true)
            switchPoigneeDefense.isEnabled = true
        }
        // Calcul et mise à jour affichage
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
        majScore()
    }
 
    
    
    @IBAction func affecterPoints(_ sender: UISlider) {
        sliderPoints.changerValeur(round(sliderPoints.value))
        // Calcul et mise à jour affichage
        scoreJeu.pointsFaits = sliderPoints.value
        majScore()
    }
    
    @IBAction func ajouterPointsAttaque(_ sender: UIButton) {
        sliderPoints.value += 0.5
        // Calcul et mise à jour affichage
        scoreJeu.pointsFaits = sliderPoints.value
        majScore()

}
    @IBAction func ajouterPointsDefense(_ sender: UIButton) {
        sliderPoints.value -= 0.5
        // Calcul et mise à jour affichage
        scoreJeu.pointsFaits = sliderPoints.value
        majScore()
}
    
    //
    //              Options Chelem
    //
    @IBAction func changerSwitchAttaque(_ sender: UISwitch) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.isEnabled = false
        }
        switchChelemDefense.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn)
        majScore()
        
    }
    
    @IBAction func changerSwitchChelemDefense(_ sender: UISwitch) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.isEnabled = false
        }
        switchChelemAttaque.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        calculerPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn)
        majScore()
        
    }
    
    @IBAction func selectionnerChelem(_ sender: UIButton) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            switchChelemAttaque.setOn(true, animated: true)
            switchChelemAttaque.isEnabled = true
            switchChelemDefense.setOn(false, animated: true)
            switchChelemDefense.isEnabled = true
        } else if switchChelemAttaque.isOn == true && switchChelemDefense.isOn == false {
            switchChelemAttaque.setOn(false, animated: true)
            switchChelemAttaque.isEnabled = true
            switchChelemDefense.setOn(true, animated: true)
            switchChelemDefense.isEnabled = true
        } else {
            switchChelemAttaque.setOn(false, animated: true)
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.setOn(false, animated: true)
            switchChelemDefense.isEnabled = false
        }
        // Calcul et mise à jour affichage
        calculerPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn)
        majScore()
        
    }
    

    
    
    
    

    
    @IBAction func Retour(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
