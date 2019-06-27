//
//  Structure comptage jeu.swift
//  Tarot
//
//  Created by Serge Gori on 17/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

struct JeuComplet {
    
    let nbPointsMaxi: Float = 91.0
    let baseContrat: Float = 25.0
    //let pointsAFaireChelem
    let contrats: [Int: String] = [1: "Petite", 2: "Garde", 3: "Garde sans", 4: "Garde contre"]
    let chelems: [Int: String] = [ -3: "Chelem annoncé et non réalisé (défense)", -2: "Chelem annoncé et réalisé (défense)", -1: "Chelem non annoncé réalisé (défense)", 0: "Pas de chelem", 1: "Chelem non annoncé réalisé (attaque)", 2: "Chelem annoncé et réalisé (attaque)", 3: "Chelem annoncé et non réalisé (attaque)"]

    let pointsARealiserValeurs: [Int: Float] = [0: 56, 1: 51, 2: 41, 3: 36]
    let coefficientsValeurs: [Int: Float] = [1: 1, 2: 2, 3: 4, 4: 6]
    let petitAuBoutValeurs: [Int: Float] = [-1: -10, 0: 0, 1: 10]
    let poigneeValeurs: [Int: Float] = [-3: -40, -2: -30, -1: -20, 0: 0, 1: 20, 2: 30, 3: 40]
    let chelemValeurs: [Int: Float] = [ -3: -200, -2: -400, -1: -200, 0: 0, 1: 200, 2: 400, 3: -200]
    
    let texteVierge = " "
    
    var total: Float?
    var gain: Float?
    var isReussi: Bool?
    var coef: Float?
    
    var contrat: Int = 0 {
        didSet {
            calculerCoef()
        }
    }
    var nbBout: Int = -1 {
        didSet {
            calculerGain()
        }
    }
    
    var pointsFaits: Float = -1.0 {
        didSet {
            calculerGain()
        }
    }
    
    var petitAuBout: Int = 0 {
        didSet {
            calculerPetitAuBout()
        }
    }
    
    var poignee: Int = 0 {
        didSet {
            calculerPoignee()
        }
    }
    
    var chelem: Int = 0 {
        didSet {
            calculerChelem()
        }
    }
    
    var pointsPetitAuBout: Float = 0
    var pointsPoignee: Float = 0
    var pointsChelem: Float = 0
    
    init(Contrat contrat: Int,
         NombreDeBout nbBout: Int,
         PointFaits pointsFaits: Float,
         PetitAuBout petitAuBout: Int,
         Poignée poignee: Int,
         Chelem chelem: Int) {
        self.contrat = contrat; calculerCoef()
        self.nbBout = nbBout; self.pointsFaits = pointsFaits; calculerGain()
        self.petitAuBout = petitAuBout; calculerPetitAuBout()
        self.poignee = poignee; calculerPoignee()
        self.chelem = chelem; calculerChelem()
    }
    
    init() {
        total = 0
        coef = 0
        gain = nbPointsMaxi
        contrat = 0
        nbBout = -1
        pointsFaits = -1
        petitAuBout = 0
        poignee = 0
        chelem = 0
        pointsPetitAuBout = 0
        pointsPoignee = 0
        pointsChelem = 0
    }
    
    mutating func calculerCoef() {
        if let coefficient = coefficientsValeurs[contrat] {
            coef = coefficient
        }
        print("Coef = \(coef ?? 0)")
        total = calculerTotal()
    }
    mutating func calculerGain() {
        if let nbPointsARealiser = pointsARealiserValeurs[nbBout] {
            gain = Float(pointsFaits - nbPointsARealiser)
            if pointsFaits >= 0 {
                isReussi = gain! >= Float(0)
            }
        }
        print("Gain = \(gain ?? 0)")
        total = calculerTotal()
    }
    mutating func calculerPetitAuBout() {
        if let nbPointsPetitAuBout = petitAuBoutValeurs[petitAuBout] {
            pointsPetitAuBout = nbPointsPetitAuBout
        }
        print("Petit au bout = \(pointsPetitAuBout)")
        total = calculerTotal()
    }
    mutating func calculerPoignee() {
        if let nbPointsPoignee = poigneeValeurs[poignee] {
            pointsPoignee = nbPointsPoignee
        }
        print("Point poignée = \(pointsPoignee)")
        total = calculerTotal()
    }
    mutating func calculerChelem() {
        if let nbPointsChelem = chelemValeurs[chelem] {
            pointsChelem = nbPointsChelem
        }
        print("Chelem = \(pointsChelem)")
        total = calculerTotal()
    }

    func calculerTotal() -> Float {
        var total: Float = 0
        if pointsARealiserValeurs[nbBout] != nil && coefficientsValeurs[contrat] != nil && pointsFaits >= 0 {
            if isReussi ?? false {
                total = (baseContrat + gain! + pointsPetitAuBout) * coef! + abs(pointsPoignee) + pointsChelem
            } else {
                total = (baseContrat - gain! - pointsPetitAuBout) * coef! + abs(pointsPoignee) - pointsChelem
                total *= -1.0
            }
            print("Total = \(total)")
        } else {
            
        }
        return total
    }
    
    // Texte points : GAIN
    func gainText() -> String {
        guard gain! != nbPointsMaxi && pointsFaits >= Float(0) else { return texteVierge }
        return String(gain!)
    }
    
    
    // Texte points : BASE CONTRAT
    func baseTxt() -> String {
        guard contrat > 0 else { return texteVierge }
        guard isReussi ?? true else { return "-" + String(baseContrat) }
        return String(baseContrat)
    }
    
    
    // Texte points : POINTS
    func pointsFaitsTxt() -> String {
        guard pointsFaits >= Float(0) else { return String(nbPointsMaxi - pointsFaits) }
        return String(pointsFaits)
    }
    
    
    // Texte points : PETIT AU BOUT
    func pointsPetitAuBoutTxt() -> String {
        guard pointsPetitAuBout != Float(0) else { return texteVierge }
        guard pointsPetitAuBout >= Float(0) else { return "(Défense)  " + String(pointsPetitAuBout) }
        return String(pointsPetitAuBout)
    }
    
    
    // Texte points : POIGNEE
    func pointsPoigneeTxt() -> String {
        guard pointsPoignee != Float(0) else { return texteVierge }
        var txt = ""
        if pointsPoignee < Float(0) {
            txt = "(Défense)  "
        }
        if !(isReussi ?? false) {
            txt += " -"
        }
        txt += String(abs(pointsPoignee))
        return txt
    }
    
    
    // Texte points : CHELEM
    func pointsChelemTxt() -> String {
        guard pointsChelem != Float(0) else { return texteVierge }
        var txt = ""
        ////            if pointsChelem < Float(0) {
        ////                txt = "(Défense)  "
        ////            }
        //            if !(scoreJeu.isReussi ?? false) {
        //                labelPointsChelem.text = labelPointsChelem.text! + " -"
        //            }
        txt += String(pointsChelem)
        return txt
    }
    
    
    // Texte points : SOUS-TOTAL
    func SousTotalTxt() -> String {
        guard (gain! != nbPointsMaxi && pointsFaits >= Float(0) && nbBout >= 0 && contrat > 0) else { return texteVierge }
        var st: Float
        if isReussi ?? false {
            st = baseContrat + (gain ?? 0.0) + pointsPetitAuBout
        } else {
            st = -(baseContrat - (gain ?? 0.0) - pointsPetitAuBout)
        }
        return String(Int(coef!)) + " x " + String(st)
    }
    
    
    // Texte points : TOTAL
    func totalTxt() -> String {
        guard gain! != nbPointsMaxi && pointsFaits >= Float(0) && nbBout >= 0 && contrat > 0 else { return texteVierge }
        return String(total!)
    }
}
