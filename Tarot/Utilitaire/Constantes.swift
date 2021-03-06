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
let brightnessDefaultApp = "brightnessDefaultApp"
let brightnessMemApp = "brightnessMemApp"


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

public func isInInterval(_ value: Int,from min: Int, to max: Int) -> Bool {
    return value >= min && value <= max
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

/// Permet la gestion et le passage de paramètres liées aux index de jeu d'une partie.
struct IndexJeu {
    
    init(first: Int64, last: Int64, nb: Int) {
        self.first = Int64(first)
        self.last = Int64(last)
        self.selected = Int64(last)
        self.numJeuSuivant = nb + 1
        self.offset = Int(first)
    }

    init() {
        self.init(first: 0, last: 0, nb: 0)
    }
    
    /// Mémorisation de la propriété `IdxJeu` du jeu sélectionné pour une éventuelle correction.
    var selected = Int64()

    /// Mémorisation du premier index de jeu de la partie.
    let first: Int64

    /// Mémorisation du dernier index de jeu de la partie.
    let last: Int64

    /// Numéro du jeu suivant
    let numJeuSuivant: Int

    /// Correspond à`first`au format integer.
    let offset: Int
    
    var numJeuSelected: Int {
        return numJeu(idJeu: selected)
    }
    
    /// Retourne le numéro du jeu relatif à l'index passé en paramètre.
    /// - Parameter idJeu: id du jeu pour lequel correspond le numéro du jeu de la partie.
    func numJeu(idJeu: Int64) -> Int {
        return Int(idJeu) - offset + 1
    }
}


enum How: Int {
    case asc, desc
}

/// Enumération permettant la gestion des tris et des options de ces tris.
enum TriJoueurs: Int {
    /// Tri numérique fonction de la répartition des joueurs autour de la table de jeu.
    case table
    /// Tri alphabétique fonction des surnoms des joueurs.
    case surnom
    /// Tri numérique fonction des points des joueurs.
    case points
    
    /// Retourne le nom de l'attribut (champ) en fonction de l'entité (table) servant de clef de tri.
    var attribute: String {
        switch self {
        case .table: return "ordre"
        case .surnom: return "idJoueur"
        case .points: return "points"
        }
    }
    
    /// Retourne le nom des clefs des UserDefaults servant à mémoriser l'ordre de tri pour chaque type de tri.
    var udHow: String {
        switch self {
        case .table: return tableJoueursPartieOrdre
        case .surnom: return surnomJoueursPartieOrdre
        case .points: return pointsJoueursPartieOrdre
        }
    }
    
    /// Retourne l'icone correspondant au type de tri pour chaque type de tri.
    func image(how: How) -> UIImage {
        switch self {
        case .table:
            switch how {
            case .asc:
                return UIImage(named: "icons8-tri-numérique-fin")!
            case .desc:
                return UIImage(named: "icons8-tri-numérique-inversé-fin")!
            }
        case .surnom:
            switch how {
            case .asc:
                return UIImage(named: "icons8-tri-alphabétique-fin")!
            case .desc:
                return UIImage(named: "icons8-tri-alphabétique-inversé-fin")!
            }
        case .points:
            switch how {
            case .asc:
                return UIImage(named: "icons8-tri")!
            case .desc:
                return UIImage(named: "icons8-tri-inversé")!
            }
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











