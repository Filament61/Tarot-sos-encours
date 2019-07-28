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

//newbranch


//public var joueursTab = [("Serge"), ("Phillipe"), ("Alain"), ("Marc"), ("Robert"), "Loulou"]
public var dicoJoueurs = AppDelegate.dicoJoueurs

//public var partie = AppDelegate.partie

public func dicoJoueursMaJ() {
    // Mise à jour du dictionnaire des noms des joueurs
    let personnes = Personne.all()
    dicoJoueurs.removeAll()
    for item in personnes {
        dicoJoueurs[Int(item.idJoueur)] = item.surnom
    }
}




//    class dico {
//
//        var joueur: [Int: String]
//
//    }


