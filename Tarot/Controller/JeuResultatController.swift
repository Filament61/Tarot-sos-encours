//
//  JeuResultatControllerr.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class JeuResultatController: UIViewController {
    
    
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
    @IBOutlet weak var segmentChelem: UISegmentedControl!
    @IBOutlet weak var gainLabel: UILabel!
    @IBOutlet weak var pointsAttaqueLabel: UILabel!
    @IBOutlet weak var labelPointsDefense: UILabel!
    @IBOutlet weak var labelPointsBase: UILabel!
    @IBOutlet weak var sliderPoints: SliderPoints!
    
    @IBOutlet weak var buttonEnregistrer: UIButton!
    
    @IBOutlet weak var labelPointsGain: UILabel!
    @IBOutlet weak var labelPointsSousTotal: UILabel!
    @IBOutlet weak var labelPointsPetitAuBout: UILabel!
    @IBOutlet weak var labelPointsPoignee: UILabel!
    @IBOutlet weak var labelPointsChelem: UILabel!
    @IBOutlet weak var labelContrat: UILabel!
    @IBOutlet weak var labelPointsTotaux: UILabel!
    
    
    let texteVierge = " "
    var jeuResultat = JeuComplet()
    var ttt = 12
    

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
    
    
    func affecterPointsPetitAuBout(attaque: Bool, defense: Bool) {
        if !attaque && !defense || attaque && defense {
            jeuResultat.petitAuBout = 0
        }
        if attaque {
            jeuResultat.petitAuBout = 1
        }
        if defense {
            jeuResultat.petitAuBout = -1
        }
    }
    
    func affecterPointsPoignee(attaque: Bool, defense: Bool, choixPoignee: Int) {
        if !attaque && !defense || attaque && defense {
            jeuResultat.poignee = 0
        }
        if attaque {
            jeuResultat.poignee = abs(choixPoignee + 1)
        }
        if defense {
            jeuResultat.poignee = -abs(choixPoignee + 1)
        }
    }
    func affecterPointsChelem(attaque: Bool, defense: Bool, choixChelem: Int) {
        let aiguillage: [Int: Int] = [-1:0, 0:3, 1:1, 2:2]
        if let iD = aiguillage[choixChelem] {
            if !attaque && !defense || attaque && defense {
                jeuResultat.chelem = 0
            }
            if attaque {
                jeuResultat.chelem = iD
            }
            if defense {
                jeuResultat.chelem = -iD
            }
        }
    }
    
    
    
    
    func majScore() {
        
        // label score GAIN
        if let isReussi = jeuResultat.isReussi, let gain = jeuResultat.gain {
            if isReussi {
                gainLabel.textColor = UIColor.init(red: 10/255, green: 200/255, blue: 30/255, alpha: 1)
            } else {
                gainLabel.textColor = UIColor.init(red: 200/255, green: 10/255, blue: 60/255, alpha: 1)
            }
            gainLabel.text = String(gain)
        }
        
        
        // label points : GAIN
        labelPointsGain.text = jeuResultat.gainText()
        
        // label points : BASE CONTRAT
        labelPointsBase.text = jeuResultat.baseText()
        
        // label points : POINTS
        pointsAttaqueLabel.text = jeuResultat.pointsFaitsText()
        labelPointsDefense.text = jeuResultat.pointsFaitsText(Defense: true)
        
        // label points : SOUS-TOTAL
        labelPointsSousTotal.text = jeuResultat.SousTotalText()
        
        // label points : PETIT AU BOUT
        labelPointsPetitAuBout.text = jeuResultat.pointsPetitAuBoutText()
        
        // label points : POIGNEE
        labelPointsPoignee.text = jeuResultat.pointsPoigneeText()
        
        // label points : CHELEM
        labelPointsChelem.text = jeuResultat.pointsChelemText()
        
        
        
        // label points : TOTAL
        labelPointsTotaux.text = jeuResultat.totalText()
        if let _ = jeuResultat.gain, let _ = jeuResultat.nbBout, let _ = jeuResultat.contrat {
            //        if scoreJeu.gain! != scoreJeu.nbPointsMaxi && scoreJeu.pointsFaits >= Float(0) && scoreJeu.nbBout >= 0 && scoreJeu.contrat > 0 {
            //            labelPointsTotaux.text = String(scoreJeu.total!)
            buttonEnregistrer.isEnabled = true
        } else {
            //            labelPointsTotaux.text = texteVierge
            buttonEnregistrer.isEnabled = false
        }
        
        
    }
    
    func miseEnPlace() {
        //scoreJeu.pointsFaits = sliderPoints.value
        majScore()
    }
    
    //    func sauvePointsJeu(scoreJeu jeuComplet: JeuComplet) {
    //        let pointsJeu = PointsJeu(context: AppDelegate.viewContext)
    //
    //        pointsJeu.contrat = Int16(jeuComplet.contrat)
    //        pointsJeu.nbBout = Int16(jeuComplet.nbBout)
    //        pointsJeu.pointsFaits = jeuComplet.pointsFaits
    //        pointsJeu.petitAuBout = Int16(jeuComplet.petitAuBout)
    //        pointsJeu.poignee = Int16(jeuComplet.poignee)
    //        pointsJeu.chelem = Int16(jeuComplet.chelem)
    //        pointsJeu.total = jeuComplet.total ?? 0.0
    //
    //        do {
    //            try? AppDelegate.viewContext.save()
    //        }
    //        catch {
    //
    //        }
    //    }
    

//  MARK: IBActions
    
    @IBAction func ButtonLecture(_ sender: Any) {
        let jeuComplet = JeuResultat.all.last
        
        jeuResultat.contrat = Int(jeuComplet?.contrat ?? 0)
        jeuResultat.nbBout = Int(jeuComplet?.nbBout ?? 0)
        jeuResultat.pointsFaits = jeuComplet?.pointsFaits ?? 0.0
        jeuResultat.petitAuBout = Int(jeuComplet?.petitAuBout ?? 0)
        jeuResultat.poignee = Int(jeuComplet?.poignee ?? 0)
        jeuResultat.chelem = Int(jeuComplet?.chelem ?? 0)
        jeuResultat.total = jeuComplet?.total ?? 0.0

        majScore()
    }
    
    @IBAction func addScore(_ sender: Any) {
//        sauvePointsJeu(scoreJeu: scoreJeu)
        JeuResultat.save(scoreJeu: jeuResultat)
    }
    
    //
    //              Options Contrats
    //
    @IBAction func selectionnerContrat(_ sender: UISegmentedControl) {
        jeuResultat.contrat = sender.selectedSegmentIndex + 1
        // Calcul et mise à jour affichage
        majScore()
    }
    
    //
    //              Options Nombre de Bout
    //
    @IBAction func selectionnerNbBout(_ sender: UISegmentedControl) {
        jeuResultat.nbBout = sender.selectedSegmentIndex
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
        affecterPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
        majScore()

    }
    
    @IBAction func changerSwitchPetitAuBoutDefense(_ sender: UISwitch) {
        if switchPetitAuBoutAttaque.isOn == false && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.isEnabled = false
        }
        switchPetitAuBoutAttaque.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        affecterPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
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
        affecterPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
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
        affecterPointsPoignee(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
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
        affecterPointsPoignee(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
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
        affecterPointsPoignee(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
        majScore()
    }
 
    
    
    @IBAction func affecterPoints(_ sender: UISlider) {
        sliderPoints.changerValeur(round(sliderPoints.value))
        // Calcul et mise à jour affichage
        jeuResultat.pointsFaits = sliderPoints.value
        majScore()
    }
    
    @IBAction func ajouterPointsAttaque(_ sender: UIButton) {
        sliderPoints.value += 0.5
        // Calcul et mise à jour affichage
        jeuResultat.pointsFaits = sliderPoints.value
        majScore()

}
    @IBAction func ajouterPointsDefense(_ sender: UIButton) {
        sliderPoints.value -= 0.5
        // Calcul et mise à jour affichage
        jeuResultat.pointsFaits = sliderPoints.value
        majScore()
}
    
    //
    //              Options Chelem
    //
    @IBAction func changerSwitchChelemAttaque(_ sender: UISwitch) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            segmentChelem.selectedSegmentIndex = UISegmentedControl.noSegment
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.isEnabled = false
        }
        switchChelemDefense.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        affecterPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn, choixChelem: segmentChelem.selectedSegmentIndex)
        majScore()
    }
    
    @IBAction func changerSwitchChelemDefense(_ sender: UISwitch) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            segmentChelem.selectedSegmentIndex = UISegmentedControl.noSegment
            switchChelemAttaque.isEnabled = false
            switchChelemDefense.isEnabled = false
        }
        switchChelemAttaque.setOn(false, animated: true)
        // Calcul et mise à jour affichage
        affecterPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn, choixChelem: segmentChelem.selectedSegmentIndex)
        majScore()
    }
    
    @IBAction func selectionnerChelem(_ sender: UISegmentedControl) {
        if switchChelemAttaque.isOn == false && switchChelemDefense.isOn == false {
            switchChelemAttaque.setOn(true, animated: true)
            switchChelemAttaque.isEnabled = true
//            switchChelemDefense.setOn(false, animated: true)
//            switchChelemDefense.isEnabled = true
        }
        // Calcul et mise à jour affichage
        affecterPointsChelem(attaque: switchChelemAttaque.isOn, defense: switchChelemDefense.isOn, choixChelem: segmentChelem.selectedSegmentIndex)
        majScore()
    }
    

    
    
    
    

    
    @IBAction func Retour(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
