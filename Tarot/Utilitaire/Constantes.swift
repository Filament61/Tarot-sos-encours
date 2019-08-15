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

let defaultSettings = UserDefaults.standard

public var triJoueursDefaut = Int()
public var triJoueursPartie = Int()


//newbranch


//public var joueursTab = [("Serge"), ("Phillipe"), ("Alain"), ("Marc"), ("Robert"), "Loulou"]
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



enum TriJoueurs: Int {
    case table, surnom, points
    
    var attribute: String {
        switch self {
        case .table: return "ordre"
        case .surnom: return "idJoueur"
        case .points: return "points"
        }
    }

    static func choixTri(choix: TriJoueurs) -> (_ item0: Joueur, _ item1: Joueur) -> Bool {
        switch choix {
        case .table:
            func table(item0: Joueur, item1: Joueur) -> Bool {
                return item0.ordre < item1.ordre
            }
            return table(item0:item1:)
        case .points:
            func points(item0: Joueur, item1: Joueur) -> Bool {
                return item0.points > item1.points
            }
            return points(item0:item1:)
        case .surnom:
            func surnom(item0: Joueur, item1: Joueur) -> Bool {
                if let j0 = dicoJoueurs[item0.idJoueur], let j1 = dicoJoueurs[item1.idJoueur] {
                    return j0 < j1
                }
                return false
            }
            return surnom(item0:item1:)
        }
    }
        
}











