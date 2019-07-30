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

    let contrats: [Int: String] = [1: "Petite",
                                   2: "Garde",
                                   3: "Garde sans",
                                   4: "Garde contre"]
    
    let chelems: [Int: String] = [ -3: "Chelem annoncé et non réalisé (défense)",
                                   -2: "Chelem annoncé et réalisé (défense)",
                                   -1: "Chelem non annoncé réalisé (défense)",
                                   0: "Pas de chelem",
                                   1: "Chelem non annoncé réalisé",
                                   2: "Chelem annoncé et réalisé",
                                   3: "Chelem annoncé et non réalisé"]

    let pointsARealiserValeurs: [Int: Float] = [0: 56, 1: 51, 2: 41, 3: 36]
    let coefficientsValeurs: [Int: Float] = [1: 1, 2: 2, 3: 4, 4: 6]
    let petitAuBoutValeurs: [Int: Float] = [-1: -10, 0: 0, 1: 10]
    let poigneeValeurs: [Int: Float] = [-3: -40, -2: -30, -1: -20, 0: 0, 1: 20, 2: 30, 3: 40]
    let chelemValeurs: [Int: Float] = [ -3: -200, -2: -400, -1: -200, 0: 0, 1: 200, 2: 400, 3: -200]
    
    let texteVierge = " "
    
    var total: Float?
    var gain: Float?
    var coef: Float?
    
//    var contrat: Int = 0 {
        var contrat: Int? {
            
        didSet {
            calculerCoef()
        }
    }
//    var nbBout: Int = -1 {
        var nbBout: Int? {
        didSet {
            calculerGain()
        }
    }
    
//    var pointsFaits: Float = -1.0 {
        var pointsFaits: Float?  {
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
//        total = 0
//        coef = 0
//        gain = nbPointsMaxi
//        contrat = 0
//        nbBout = -1
//        pointsFaits = -1
        petitAuBout = 0
        poignee = 0
        chelem = 0
//        pointsPetitAuBout = 0
//        pointsPoignee = 0
//        pointsChelem = 0
    }
    
    
    var isReussi: Bool? {
        get {
            guard let gain = gain else { return nil }
            return gain >= Float(0)
        }
    }
    mutating func calculerCoef() {
        if let contrat = contrat {
            coef = coefficientsValeurs[contrat]
        }
        print("Coef = \(coef ?? 0)")
        total = calculerTotal()
    }
    mutating func calculerGain() {
        if let nbBout = nbBout, let pointsFaits = pointsFaits {
            if let nbPointsARealiser = pointsARealiserValeurs[nbBout] {
                gain = pointsFaits - nbPointsARealiser
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

    func calculerTotal() -> Float? {
        guard let isReussi = isReussi, let gain = gain, let coef = coef else { return nil }
        var total: Float = 0
        if isReussi {
            total = (baseContrat + gain + pointsPetitAuBout) * coef + abs(pointsPoignee) + pointsChelem
        } else {
            total = (baseContrat - gain - pointsPetitAuBout) * coef + abs(pointsPoignee) - pointsChelem
            total *= -1.0
        }
        print("Total = \(total)")
        return total
    }
    
    // Texte points : GAIN
    func gainText() -> String {
        guard let gain = gain, let _ = pointsFaits else { return texteVierge }
        return String(gain)
    }
    
    // Texte points : BASE CONTRAT
    func baseText() -> String {
        guard  let isReussi = isReussi, let _ = contrat else { return texteVierge }
        if isReussi {
            return String(baseContrat)
        } else {
            return "-" + String(baseContrat) }
    }
    
    // Texte points : POINTS
    func pointsFaitsText(Defense def: Bool = false) -> String {
        guard let pointsFaits = pointsFaits else { return texteVierge }
        if def {
            return String(nbPointsMaxi - pointsFaits)
        } else {
            return String(pointsFaits)
        }
    }
    
    // Texte points : PETIT AU BOUT
    func pointsPetitAuBoutText() -> String {
        guard pointsPetitAuBout != Float(0) else { return texteVierge }
        guard pointsPetitAuBout >= Float(0) else { return "(Défense)  " + String(pointsPetitAuBout) }
        return String(pointsPetitAuBout)
    }
    
    // Texte points : POIGNEE
    func pointsPoigneeText() -> String {
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
    func pointsChelemText() -> String {
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
    func SousTotalText() -> String {
        guard let gain = gain, let isReussi = isReussi, let coef = coef else { return texteVierge }
//        guard (gain! != nbPointsMaxi && pointsFaits >= Float(0) && nbBout >= 0 && contrat > 0) else { return texteVierge }
        var st: Float
        if isReussi {
            st = baseContrat + gain + pointsPetitAuBout
        } else {
            st = -(baseContrat - gain - pointsPetitAuBout)
        }
        return String(Int(coef)) + " x " + String(st)
    }
    
    // Texte points : TOTAL
    func totalText() -> String {
        guard let _ = gain, let _ = nbBout, let _ = contrat else { return texteVierge }
        return String(total!)
    }
}
