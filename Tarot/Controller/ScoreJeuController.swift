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
    
    
    @IBOutlet weak var labelEspion: UILabel!
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
    
    @IBOutlet weak var sliderPoints: SliderPoints!
    
    
    var scoreJeu = JeuPoints(resultat: 0.0, gain: 0.0, points: 0.0, coef: 0, nbBout: -1, attaque: PrimePoints(), defense: PrimePoints())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //miseEnPlaceImagePicker()
        miseEnPlacePicker()
        //miseEnPlaceTextField()
        //miseEnPlaceNotification()
        //fetchEntreprises()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //largeurContrainte.constant = view.frame.width
        //scroll.contentSize = CGSize(width: largeurContrainte.constant, height: scroll.frame.height)
    }
    
    

    
    
    func calculerPointsPetitAuBout(attaque: Bool, defense: Bool) {
//        if attaque {
//            scoreJeu.attaque.petitAuBout = valeurPetitAuBout
//        } else {
//            scoreJeu.attaque.petitAuBout = 0.0
//        }
//        if defense {
//            scoreJeu.defense.petitAuBout = valeurPetitAuBout
//        } else {
//            scoreJeu.defense.petitAuBout = 0.0
//        }
        print("Petit au bout attaque : \(scoreJeu.attaque.petitAuBout)")
        print("Petit au bout défence : \(scoreJeu.defense.petitAuBout)")
    }
    
    func calculerPointsPoignée(attaque: Bool, defense: Bool, choixPoignee: Int) {
        var valeurPoignee = 0.0
        
        //        switch segment.selectedSegmentIndex
        //        {
        //        case UISegmentedControl.noSegment:
        //            valeurPoignee = 0.0
        switch choixPoignee
        {
        case -1:
            valeurPoignee = 0.0
        // Aucune poignée sélectionnée
        case 0:
            valeurPoignee = valeurPoigneeSimple
        // Simple poignée sélectionnée
        case 1:
            valeurPoignee = valeurPoigneeDouble
        // Double poignée sélectionnée
        case 2:
            valeurPoignee = valeurPoigneeTriple
        // Triple poignée sélectionnée
        default:
            break;
        }
        
        if attaque {
            scoreJeu.attaque.poignee = valeurPoignee
        } else {
            scoreJeu.attaque.poignee = 0.0
        }
        if switchPoigneeDefense.isOn {
            scoreJeu.defense.poignee = valeurPoignee
        } else {
            scoreJeu.defense.poignee = 0.0
        }
        print("choixPoignee : \(choixPoignee)")
        print("scoreJeu.poignée.attaque : \(scoreJeu.attaque.poignee)")
        print("scoreJeu.poignée.defense : \(scoreJeu.defense.poignee)")
        
        return
    }
    
    func calculerGain(nbBoutsAttaque: Int, nbPointsAttaque: Float) {
        if let nbPointsArealiser = bouts[nbBoutsAttaque] {
            scoreJeu.gain = Float(nbPointsAttaque - nbPointsArealiser)
            if scoreJeu.gain >= 0.0 {
                labelGain.textColor = UIColor.green
            } else {
                labelGain.textColor = UIColor.red
            }
            labelGain.text = String(scoreJeu.gain)
        }
        print("scoreJeu.gain : \(scoreJeu.gain)")
      }
    
    
    
//MARK: IBActions
    
    //
    //              Options Contrats
    //
    @IBAction func selectionnerContrat(_ sender: UISegmentedControl) {
    }
    
    //
    //              Options Nombre de Bout
    //
    @IBAction func selectionnerNbBout(_ sender: UISegmentedControl) {
        scoreJeu.nbBout = sender.selectedSegmentIndex
        calculerGain(nbBoutsAttaque: scoreJeu.nbBout, nbPointsAttaque: scoreJeu.points)
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
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
    }
    
    @IBAction func changerSwitchPetitAuBoutDefense(_ sender: UISwitch) {
        if switchPetitAuBoutAttaque.isOn == false && switchPetitAuBoutDefense.isOn == false {
            switchPetitAuBoutAttaque.isEnabled = false
            switchPetitAuBoutDefense.isEnabled = false
        }
        switchPetitAuBoutAttaque.setOn(false, animated: true)
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
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
        calculerPointsPetitAuBout(attaque: switchPetitAuBoutAttaque.isOn, defense: switchPetitAuBoutDefense.isOn)
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
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
    }

    @IBAction func changerSwitchPoigneeDefense(_ sender: UISwitch) {
        if switchPoigneeAttaque.isOn == false && switchPoigneeDefense.isOn == false {
            segmentPoignee.selectedSegmentIndex = UISegmentedControl.noSegment
            switchPoigneeAttaque.isEnabled = false
            switchPoigneeDefense.isEnabled = false
        }
        switchPoigneeAttaque.setOn(false, animated: true)
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
    }

    @IBAction func selectionnerSegmentPoignee(_ sender: UISegmentedControl) {
        if switchPoigneeAttaque.isOn == false && switchPoigneeDefense.isOn == false {
            switchPoigneeAttaque.setOn(true, animated: true)
            switchPoigneeAttaque.isEnabled = true
            switchPoigneeDefense.setOn(false, animated: true)
            switchPoigneeDefense.isEnabled = true
        }
        calculerPointsPoignée(attaque: switchPoigneeAttaque.isOn, defense: switchPoigneeDefense.isOn, choixPoignee: segmentPoignee.selectedSegmentIndex)
    }
 
    
    
    @IBAction func affecterPoints(_ sender: UISlider) {
        sliderPoints.changerValeur(round(sliderPoints.value))
        scoreJeu.points = sliderPoints.value
        print(sliderPoints.value)
        print(scoreJeu.points)
        calculerGain(nbBoutsAttaque: scoreJeu.nbBout, nbPointsAttaque: scoreJeu.points)
//        let step: Float = 1
//        sliderPoints.value = round(sender.value / step) * step
        labelPointsDefense.text = String(Float(nbPointsMaxi) - sliderPoints.value)
        labelPointsAttaque.text = String(sliderPoints.value)
        }
    
    @IBAction func ajouterPointsAttaque(_ sender: UIButton) {
        sliderPoints.value += 0.5
        scoreJeu.points = sliderPoints.value
        print(sliderPoints.value)
        print(scoreJeu.points)
        
        labelPointsDefense.text = String(Float(nbPointsMaxi) - sliderPoints.value)
        labelPointsAttaque.text = String(sliderPoints.value)
        calculerGain(nbBoutsAttaque: scoreJeu.nbBout, nbPointsAttaque: scoreJeu.points)
}
    @IBAction func ajouterPointsDefense(_ sender: UIButton) {
        sliderPoints.value -= 0.5
        labelPointsDefense.text = String(Float(nbPointsMaxi) - sliderPoints.value)
        labelPointsAttaque.text = String(sliderPoints.value)
        calculerGain(nbBoutsAttaque: scoreJeu.nbBout, nbPointsAttaque: scoreJeu.points)
}
    
    func calculerScoreJeu() {
        if segmentNbBout.selectedSegmentIndex != UISegmentedControl.noSegment {
            scoreJeu.nbBout = segmentNbBout.selectedSegmentIndex
        }
//        calculerPoignée()
//        calculerPetitAuBout()
        
    }
  
    
    
    
    
    

    
    @IBAction func Retour(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
