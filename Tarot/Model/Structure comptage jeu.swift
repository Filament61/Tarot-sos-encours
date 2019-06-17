//
//  Structure comptage jeu.swift
//  Tarot
//
//  Created by Serge Gori on 17/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

struct JeuComplet {
    
    let baseContrat: Float = 25
    let pointsARealiser: [Int: Float] = [0: 56, 1: 51, 2: 41, 3: 36]
    let contrats: [Int: String] = [1: "Petite", 2: "Garde", 3: "Garde sans", 4: "Garde contre"]
    let coefficients: [Int: Float] = [1: 1, 2: 2, 3: 4, 4: 6]
    
    let petitAuBoutValeur: [Int: Float] = [-1: -10, 0: 0, 1: 10]
    let poigneeValeurs: [Int: Float] = [-3: -40, -2: -30, -1: -20, 0: 0, 1: 20, 2: 30, 3: 40]
    let chelemValeur: [Int: String] = [0: "Pas de Chelem"]
    
    
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
    
    var pointsPetitAuBout: Float = 0
    var pointsPoignee: Float = 0
    var pointsChelem: Float = 0
    
    
    
    init() {
        total = 0
        coef = 0
        gain = -baseContrat
        contrat = 0
        nbBout = -1
        pointsFaits = -1
        petitAuBout = 0
        poignee = 0
        pointsPetitAuBout = 0
        pointsPoignee = 0
        pointsChelem = 0
    }
    
    mutating func calculerCoef() {
        if let coefficient = coefficients[contrat] {
            coef = coefficient
        }
        print("Coef = \(coef ?? 0)")
        total = calculerTotal()
    }
    mutating func calculerGain() {
        if let nbPointsARealiser = pointsARealiser[nbBout] {
            gain = Float(pointsFaits - nbPointsARealiser)
            isReussi = gain! >= Float(0)
        }
        print("Gain = \(gain ?? 0)")
        total = calculerTotal()
    }
    mutating func calculerPetitAuBout() {
        if let nbpointsPoignee = petitAuBoutValeur[petitAuBout] {
            pointsPetitAuBout = nbpointsPoignee
        }
        print("Petit au bout = \(pointsPetitAuBout)")
        total = calculerTotal()
    }
    mutating func calculerPoignee() {
        if let nbpointsPoignee = poigneeValeurs[poignee] {
            pointsPoignee = nbpointsPoignee
        }
        print("Point poignée = \(pointsPoignee)")
        total = calculerTotal()
    }
    
    func calculerTotal() -> Float {
        var total: Float
        if isReussi ?? false {
            total = (baseContrat + gain! + pointsPetitAuBout) * coef! + abs(pointsPoignee)
        } else {
            total = (baseContrat - gain! - pointsPetitAuBout) * coef! + abs(pointsPoignee)
            total *= -1.0
        }
        print("Total = \(total)")
        return total
    }
    
}
