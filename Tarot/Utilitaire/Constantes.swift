//
//  Constantes.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//


import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let viewContext = AppDelegate.persistentContainer.viewContext

// MARK: - Paramétrage
let defaultSettings = UserDefaults.standard
let triJoueursPartie = "triJoueursPartie"
let triJoueursDefaut = "triJoueursDefaut"
let tableJoueursPartieOrdre = "tableJoueursPartieOrdre"
let surnomJoueursPartieOrdre = "surnomJoueursPartieOrdre"
let pointsJoueursPartieOrdre = "pointsJoueursPartieOrdre"
let donneAffJoueurs = "donneAffJoueurs"
let pointsAffJoueurs = "pointsAffJoueurs"
let jeuDernierAffJoueurs = "jeuDernierAffJoueurs"
let jeuxAffJoueurs = "jeuxAffJoueurs"
let jeuxAffJoueursEnCours = "jeuxAffJoueursEnCours"
let jeuxcellAffJoueursEnCours = "jeuxcellAffJoueursEnCours"
let decimaleAffJoueurs = "decimaleAffJoueurs"


//public var triJoueursDefaut = Int()
//public var triJoueursPartie = Int()





public var dicoJoueurs = AppDelegate.dicoJoueurs

//public var partie = AppDelegate.partie

public func dicoJoueursMaJ() {
    // Mise à jour du dictionnaire des noms des joueurs
    let personnes = Personne.all()
    dicoJoueurs.removeAll()
    for item in personnes {
        dicoJoueurs[item.idJoueur] = item.surnom
    }
}


extension Int {
    func minus(De valeur: Int = 1) -> Int { return self - valeur}
    func plus(De valeur: Int = 1) -> Int { return self + valeur}
}

struct FloatString {
    static var decimal = Bool()
    init(float: Float) {
        self.float = float
    }
    var string: String {
         return FloatString.decimal ? String(float) : String(Int(float))
    }
    var float: Float
}


enum How: Int {
    case asc, desc
}

enum TriJoueurs: Int {
    case table, surnom, points
    
    var attribute: String {
        switch self {
        case .table: return "ordre"
        case .surnom: return "idJoueur"
        case .points: return "points"
        }
    }
    
        var udHow: String {
            switch self {
            case .table: return tableJoueursPartieOrdre
            case .surnom: return surnomJoueursPartieOrdre
            case .points: return pointsJoueursPartieOrdre
            }
        }
    
    static func choixTri(choix: TriJoueurs, how: How) -> (_ item0: Joueur, _ item1: Joueur) -> Bool {
        switch choix {
        case .table:
            switch how {
            case .asc:
                func table(item0: Joueur, item1: Joueur) -> Bool {
                    return item0.ordre < item1.ordre
                }
                return table(item0:item1:)
            case .desc:
                func table(item0: Joueur, item1: Joueur) -> Bool {
                    return item0.ordre > item1.ordre
                }
                return table(item0:item1:)
            }
        case .points:
            switch how {
            case .asc:
                func points(item0: Joueur, item1: Joueur) -> Bool {
                    return item0.points < item1.points
                }
                return points(item0:item1:)
            case .desc:
                func points(item0: Joueur, item1: Joueur) -> Bool {
                    return item0.points > item1.points
                }
                return points(item0:item1:)
            }
        case .surnom:
            switch how {
            case .asc:
                func surnom(item0: Joueur, item1: Joueur) -> Bool {
                    if let j0 = dicoJoueurs[item0.idJoueur], let j1 = dicoJoueurs[item1.idJoueur] {
                        return j0 < j1
                    }
                    return false
                }
                return surnom(item0:item1:)
            case .desc:
                func surnom(item0: Joueur, item1: Joueur) -> Bool {
                    if let j0 = dicoJoueurs[item0.idJoueur], let j1 = dicoJoueurs[item1.idJoueur] {
                        return j0 > j1
                    }
                    return false
                }
                return surnom(item0:item1:)
            }
        }
    }
    
}











