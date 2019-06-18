////
////  DonneesTarot.swift
////  Tarot
////
////  Created by Serge Gori on 14/06/2019.
////  Copyright © 2019 Serge Gori. All rights reserved.
////
//
//import Foundation
//
//
//let nbPointsMaxi = 91.0
//
//let nbPoints0Bout = 56.0
//let nbPoints1Bout = 51.0
//let nbPoints2Bouts = 41.0
//let nbPoints3Bouts = 36.0
//
//let valeurContratBase = 25.0
//let valeurPetitAuBout = 10.0
//
//let coefPetite = 1
//let coefGarde = 2
//let coefGardeSans = 4
//let coefGardeContre = 6
//
//let valeurPoigneeSimple = 20.0
//let valeurPoigneeDouble = 30.0
//let valeurPoigneeTriple = 40.0
//
//let contrats: [Int: String] = [1: "Petite", 2: "Garde", 3: "Garde sans", 4: "Garde contre"]
//let oefficients: [String: Int] = ["Petite": 1, "Garde": 2, "Garde sans": 4, "Garde contre": 6]
//let bouts: [Int: Float] = [0: 56, 1: 51, 2: 41, 3: 36]
//
//
//let scoreNul = JeuPoints(resultat: 0.0, gain: 0.0, points: 0.0, coef: 0, nbBout: -1, attaque: PrimePoints(), defense: PrimePoints())
//let primeNulle = PrimePoints()
//
//struct PrimePoints {
//    var petitAuBout = 0.0
//    var poignee = 0.0
//    var chelem = 0.0
//}
//
//struct JeuPoints {
//    var resultat = 0.0
//    var gain: Float = 0.0
//    var points:Float = 0.0 {
//        didSet {
//            calculer()
//        }
//    }
//    var coef = 0
//    var nbBout = 0
//    var attaque: PrimePoints
//    var defense: PrimePoints
//
//    func calculer() {
//            print("Coucou")
//    }
//
//
//}
//
//
