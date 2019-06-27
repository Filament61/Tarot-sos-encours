////
////  Points.swift
////  Tarot
////
////  Created by Serge Gori on 26/06/2019.
////  Copyright © 2019 Serge Gori. All rights reserved.
////
//
//
//
//
//
//class Points {
//    
//    
//    let nbPointsMaxi: Float = 91.0
//    let baseContrat: Float = 25.0
//    //let pointsAFaireChelem
//    let contrats: [Int: String] = [1: "Petite", 2: "Garde", 3: "Garde sans", 4: "Garde contre"]
//    let chelems: [Int: String] = [ -3: "Chelem annoncé et non réalisé (défense)", -2: "Chelem annoncé et réalisé (défense)", -1: "Chelem non annoncé réalisé (défense)", 0: "Pas de chelem", 1: "Chelem non annoncé réalisé (attaque)", 2: "Chelem annoncé et réalisé (attaque)", 3: "Chelem annoncé et non réalisé (attaque)"]
//    
//    let pointsARealiserValeurs: [Int: Float] = [0: 56, 1: 51, 2: 41, 3: 36]
//    let coefficientsValeurs: [Int: Float] = [1: 1, 2: 2, 3: 4, 4: 6]
//    let petitAuBoutValeurs: [Int: Float] = [-1: -10, 0: 0, 1: 10]
//    let poigneeValeurs: [Int: Float] = [-3: -40, -2: -30, -1: -20, 0: 0, 1: 20, 2: 30, 3: 40]
//    let chelemValeurs: [Int: Float] = [ -3: -200, -2: -400, -1: -200, 0: 0, 1: 200, 2: 400, 3: -200]
//    
//    var toto: Int {
//        get {
//            
//        }
//        set {
//            let tata = newValue
//            calculerCoef()
//        }
//    }
//    var total: Float?
//    var gain: Float?
//    var isReussi: Bool?
//    var coef: Float?
//    
//    var contrat: Int = 0 {
//        didSet {
//            calculerCoef()
//        }
//    }
//    var nbBout: Int = -1 {
//        didSet {
//            calculerGain()
//        }
//    }
//    
//    var pointsFaits: Float = -1.0 {
//        didSet {
//            calculerGain()
//        }
//    }
//    
//    var petitAuBout: Int = 0 {
//        didSet {
//            calculerPetitAuBout()
//        }
//    }
//    
//    var poignee: Int = 0 {
//        didSet {
//            calculerPoignee()
//        }
//    }
//    
//    var chelem: Int = 0 {
//        didSet {
//            calculerChelem()
//        }
//    }
//    
//    var pointsPetitAuBout: Float = 0
//    var pointsPoignee: Float = 0
//    var pointsChelem: Float = 0
//    
//    
//    
//    init() {
//        total = 0
//        coef = 0
//        gain = nbPointsMaxi
//        contrat = 0
//        nbBout = -1
//        pointsFaits = -1
//        petitAuBout = 0
//        poignee = 0
//        chelem = 0
//        pointsPetitAuBout = 0
//        pointsPoignee = 0
//        pointsChelem = 0
//    }
//    
//    private func calculerCoef() {
//        if let coefficient = coefficientsValeurs[contrat] {
//            coef = coefficient
//        }
//        print("Coef = \(coef ?? 0)")
//        total = calculerTotal()
//    }
//    private func calculerGain() {
//        if let nbPointsARealiser = pointsARealiserValeurs[nbBout] {
//            gain = Float(pointsFaits - nbPointsARealiser)
//            if pointsFaits >= 0 {
//                isReussi = gain! >= Float(0)
//            }
//        }
//        print("Gain = \(gain ?? 0)")
//        total = calculerTotal()
//    }
//    private func calculerPetitAuBout() {
//        if let nbPointsPetitAuBout = petitAuBoutValeurs[petitAuBout] {
//            pointsPetitAuBout = nbPointsPetitAuBout
//        }
//        print("Petit au bout = \(pointsPetitAuBout)")
//        total = calculerTotal()
//    }
//    private func calculerPoignee() {
//        if let nbPointsPoignee = poigneeValeurs[poignee] {
//            pointsPoignee = nbPointsPoignee
//        }
//        print("Point poignée = \(pointsPoignee)")
//        total = calculerTotal()
//    }
//    private func calculerChelem() {
//        if let nbPointsChelem = chelemValeurs[chelem] {
//            pointsChelem = nbPointsChelem
//        }
//        print("Chelem = \(pointsChelem)")
//        total = calculerTotal()
//    }
//    
//    func calculerTotal() -> Float {
//        var total: Float = 0
//        if pointsARealiserValeurs[nbBout] != nil && coefficientsValeurs[contrat] != nil && pointsFaits >= 0 {
//            if isReussi ?? false {
//                total = (baseContrat + gain! + pointsPetitAuBout) * coef! + abs(pointsPoignee) + pointsChelem
//            } else {
//                total = (baseContrat - gain! - pointsPetitAuBout) * coef! + abs(pointsPoignee) - pointsChelem
//                total *= -1.0
//            }
//            print("Total = \(total)")
//        } else {
//            
//        }
//        return total
//    }
//    
//    
//    func majScore() {
//        // label score GAIN
//        if gain! != nbPointsMaxi && pointsFaits >= Float(0) {
//            if isReussi ?? false {
//                labelGain.textColor = UIColor.init(red: 10/255, green: 200/255, blue: 30/255, alpha: 1)
//            } else {
//                labelGain.textColor = UIColor.init(red: 200/255, green: 10/255, blue: 60/255, alpha: 1)
//            }
//            labelGain.text = String(scoreJeu.gain!)
//        }
//        
//        
//        // label points : GAIN
//        if gain! != nbPointsMaxi && pointsFaits >= Float(0) {
//            labelPointsGain.text = String(gain!)
//        } else {
//            labelPointsGain.text = texteVierge
//        }
//        
//        
//        // label points : BASE CONTRAT
//        if contrat > 0 {
//            if isReussi ?? true {
//                labelPointsBase.text = String(baseContrat)
//            } else {
//                labelPointsBase.text = "-" + String(baseContrat)
//            }
//        } else {
//            labelPointsBase.text = texteVierge
//        }
//        
//        
//        // label points : POINTS
//        if pointsFaits >= Float(0) {
//            labelPointsAttaque.text = String(pointsFaits)
//            labelPointsDefense.text = String(nbPointsMaxi - pointsFaits)
//        }
//        
//        
//        // label points : SOUS-TOTAL
//        if gain! != nbPointsMaxi && pointsFaits >= Float(0) && nbBout >= 0 && contrat > 0 {
//            var st: Float
//            if isReussi ?? false {
//                st = baseContrat + (gain ?? 0.0) + pointsPetitAuBout
//            } else {
//                st = -(baseContrat - (gain ?? 0.0) - pointsPetitAuBout)
//            }
//            labelPointsSousTotal.text = String(Int(coef!)) + " x " + String(st)
//        } else {
//            labelPointsSousTotal.text = texteVierge
//        }
//        
//        
//        // label points : PETIT AU BOUT
//        if pointsPetitAuBout != Float(0) {
//            if pointsPetitAuBout < Float(0) {
//                labelPointsPetitAuBout.text = "(Défense)  " + String(pointsPetitAuBout)
//            } else {
//                labelPointsPetitAuBout.text = String(pointsPetitAuBout)
//            }
//        } else {
//            labelPointsPetitAuBout.text = texteVierge
//        }
//        
//        
//        // label points : POIGNEE
//        if pointsPoignee == Float(0) {
//            labelPointsPoignee.text = texteVierge
//        } else {
//            labelPointsPoignee.text = ""
//            if pointsPoignee < Float(0) {
//                labelPointsPoignee.text = "(Défense)  "
//            }
//            if !(isReussi ?? false) {
//                labelPointsPoignee.text = labelPointsPoignee.text! + " -"
//            }
//            labelPointsPoignee.text = labelPointsPoignee.text! + String(abs(pointsPoignee))
//        }
//        
//        
//        // label points : CHELEM
//        if pointsChelem == Float(0) {
//            labelPointsChelem.text = texteVierge
//        } else {
//            labelPointsChelem.text = ""
//            ////            if scoreJeu.pointsChelem < Float(0) {
//            ////                labelPointsChelem.text = "(Défense)  "
//            ////            }
//            //            if !(scoreJeu.isReussi ?? false) {
//            //                labelPointsChelem.text = labelPointsChelem.text! + " -"
//            //            }
//            labelPointsChelem.text = labelPointsChelem.text! + String(pointsChelem)
//        }
//        
//        
//        
//        
//        // label points : TOTAL
//        if gain! != nbPointsMaxi && pointsFaits >= Float(0) && nbBout >= 0 && contrat > 0 {
//            labelPointsTotaux.text = String(total!)
//            buttonEnregistrer.isEnabled = true
//        } else {
//            labelPointsTotaux.text = texteVierge
//            buttonEnregistrer.isEnabled = false
//        }
//        
//        
//    }
//
//    
//    
//}
