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




class App {
    
    //        static var joueur: [Int: String]
    static public var nbJoueurs = 0
    static public var partenaire = 1
    static public var mort: [Int] = [0]
    
    static public var preneur = 0
    
    static public var donneur = varCirculaire(nb: 0)
    
}


class varCirculaire {
    private var _ordre: Int = 0
    private var _nb: Int = 0
    
    init?() {
        return nil
    }
    init(nb: Int) {
        _nb = nb
    }
    init(nb: Int, ordre: Int) {
        _nb = nb
        _ordre = ordre
    }

    var ordre: Int {
        return _ordre
    }
    
    func suivant() -> Int {
        if _ordre >= _nb {
            _ordre = 1
        } else {
            _ordre += 1
        }
        return _ordre
    }

    func precedent() -> Int {
        if _ordre <= 1 {
            _ordre = _nb
        } else {
            _ordre -= 1
        }
        return _ordre
    }
    
    func raz() -> Int {
        _ordre = 0
        return _ordre
    }
    
    func nb(nb: Int) -> Int {
        _nb = nb
        _ordre = 0
        return _nb
    }
    
    func reInit(nb: Int, ordre: Int) {
        _nb = nb
        _ordre = ordre
    }

}

