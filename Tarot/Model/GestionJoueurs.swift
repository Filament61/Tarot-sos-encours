//
//  GestionJoueurs.swift
//  Tarot
//
//  Created by Serge Gori on 30/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import Foundation
import UIKit


class GestionJoueurs {
    
    static let nbMiniJoueurs = 3
    static let nbMaxiJoueurs = 8
    
    
    func tri(choix: TriJoueurs) {
        self._joueursPartie.sort(by: TriJoueurs.choixTri(choix: choix))
    }
//    func choixTri(choix: TriJoueurs) -> (_ item0: Joueur, _ item1: Joueur) -> Bool {
//        switch choix {
//        case .table:
//            func table(item0: Joueur, item1: Joueur) -> Bool {
//                return item0.ordre < item1.ordre
//            }
//            return table(item0:item1:)
//        case .points:
//            func points(item0: Joueur, item1: Joueur) -> Bool {
//                return item0.points > item1.points
//            }
//            return points(item0:item1:)
//        case .surnom:
//            func surnom(item0: Joueur, item1: Joueur) -> Bool {
//                if let j0 = dicoJoueurs[item0.idJoueur], let j1 = dicoJoueurs[item1.idJoueur] {
//                    return j0 < j1
//                }
//                return false
//            }
//            return surnom(item0:item1:)
//        }
//    }
//
    init(joueurs: [Joueur], NouvellePartie isNouvellePartie: Bool) {
        self._joueursPartie = joueurs
        self.tri(choix: TriJoueurs(rawValue: triJoueursPartie)!)
        self._joueursEnJeu = self._joueursPartie.filter({ $0.enJeu == true })
        self._joueursEnMene = self._joueursEnJeu.filter({ $0.mort == false })
        self._joueursMort = self._joueursEnJeu.filter({ $0.mort == true })
    }
    
    var joueursPartie: [Joueur]! {
        return _joueursPartie
    }
    var nbJoueursPartie: Int {
        _nbJoueursPartie = self._joueursPartie.count
        return _nbJoueursPartie
    }

    var joueursEnMene: [Joueur]! {
        self._joueursEnMene = self._joueursEnJeu.filter({ $0.mort == false})
        return self._joueursEnMene
    }
    var nbJoueursEnMene: Int {
        _nbJoueursEnMene = self._joueursEnMene.count
        return self._nbJoueursEnMene
    }

    var joueursEnJeu: [Joueur]! {
        self._joueursEnJeu = self._joueursPartie.filter({ $0.enJeu == true})
        return self._joueursEnJeu
    }
    var nbJoueursEnjeu: Int {
        _nbJoueursEnJeu = self._joueursEnJeu.count
        return self._nbJoueursEnJeu
    }

    var joueursMort: [Joueur]! {
        self._joueursMort = self._joueursEnJeu.filter({ $0.mort == true })
        return _joueursMort
    }
    var nbJoueursMort: Int {
        _nbJoueursMort = self._joueursMort.count
        return _nbJoueursMort
    }
    
    private var _nbJoueursPartie: Int = 0
    private var _joueursPartie: [Joueur]!
    
    private var _nbJoueursEnMene: Int = 0
    private var _joueursEnMene: [Joueur]!
    
    private var _nbJoueursEnJeu: Int = 0
    private var _joueursEnJeu: [Joueur]!
    
    private var _nbJoueursMort: Int = 0
    private var _joueursMort: [Joueur]!
    
    var joueursDefense: [Joueur]!
    
    //    var nbJoueursEnMene: Int = 0
    //    var nbJoueursEnJeu: Int = 0
    
    var contrat: Contrat?
    var modeJeu: ModeJeu?
    
    var preneur: Joueur?
    var partenaire: Joueur?
    var mort: [varCirculaire]?
    
    
    func ordonner() {
        //        guard let _ = self.isCorectNbJoueurs(joueursTab: self._joueursPartie) == true else { return }
        
        
        
        
        //        switch nbJoueursEnjeu {
        //        case Int.min..<GestionJoueurs.nbMiniJoueurs:
        //            break
        //        case GestionJoueurs.nbMiniJoueurs:
        //
        //        case 4:
        //
        //        case 5:
        //
        //        case 6:
        //
        //        case 7:
        //
        //        case GestionJoueurs.nbMaxiJoueurs:
        //
        //        case GestionJoueurs.nbMaxiJoueurs...Int.max:
        //            break
        //        default: break
        //
        //        }
        
    }
    
    /// Affecte les points réalisés aux différents joueurs de la mène.
    ///
    /// - parameter points: Points de base réalisés lors du jeu (de la mène).
    /// - warning: Il n'est pas nécessaire de mettre à jour le tableau, car le système 'connait' les références des propriétés des entités !
    func affecterPoints(points: Float) {
        let coef: Float = modeJeu == ModeJeu.simple ? Float(nbJoueursEnMene.minus()) : 2.0
        
        guard let preneur = self.preneur else { return }
        preneur.points += points * coef
        // Mise à jour des joueurs en défense
        self.joueursDefense = self.joueursEnMene.filter { $0.idJoueur != preneur.idJoueur }
        
        if let partenaire = self.partenaire {
            partenaire.points += points
            // Mise à jour des joueurs en défense
            self.joueursDefense = self.joueursDefense.filter { $0.idJoueur != partenaire.idJoueur }
        }
        
        for joueur in self.joueursDefense {
            joueur.points -= points
        }
        
        return
    }
    
    
    func decodeTypePartie(typePartie: Int16) -> (nbJoueursss: Int, modeJeu: ModeJeu, nbMorts: Int) {
        let unite = typePartie.quotientAndRemainder(dividingBy: 10)
        let nbM = unite.remainder
        let dizaine = (typePartie - unite.remainder).quotientAndRemainder(dividingBy: 100)
        let mJ = dizaine.remainder / 10
        let nbJ = dizaine.quotient
        return (Int(nbJ), ModeJeu(rawValue: Int(mJ))!, Int(nbM))
    }
    
    
    func donneSuivante() {
        //        var joueursSuivants = joueurs
        //        defer {
        //            joueurs = joueursSuivants
        //        }
        // On vérifie qu'il existe au moins 1 joueur en jeu !
        //        guard let _ = joueursPartie.firstIndex(where: {$0.enJeu == true}) else { return }
        // On vérifie qu'il existe au moins 1 donneur identifié
        if let idxDonneur = joueursPartie.firstIndex(where: {$0.donneur == true}) {
            if let idx = joueursPartie.firstIndex(where: {$0.donneur == true && $0.enJeu == true}) {
                let donneur = varCirculaire(nb: nbJoueursPartie, idx: idx)
                repeat {
                    let _ = donneur.suivant()
                } while (joueursPartie[donneur.idx].enJeu == false)
                
                
                _joueursPartie[idxDonneur].donneur = false
                _joueursPartie[donneur.idx].donneur = true
            }
        } else if let idxEnJeu = joueursPartie.firstIndex(where: {$0.enJeu == true}) {
            let donneur = varCirculaire(nb: nbJoueursPartie, idx: idxEnJeu)
            let _ = donneur.suivant()
            _joueursPartie[donneur.idx].donneur = true
        }
        return
    }
    
    // TODO: - Traiter les erreurs
    func donneurSuivant() -> Bool? {
        guard GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: nbJoueursEnjeu) else { return false }
        if let joueur = joueursPartie.first(where: { $0.donneur == true }), let suivant = joueursEnJeu.first(where: { $0.ordre == joueur.suivant }) {
            joueur.donneur = false
            suivant.donneur = true
            return true
        } else {
            return false
        }
    }
    
    
    
    // TODO: - Traiter les erreurs
    func mortSuivant() -> Bool? {
        guard GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: nbJoueursEnjeu) else { return false }
        let joueurs = joueursMort.sorted(by: { $0.suivant > $1.suivant })
        if !joueurs.isEmpty {
            let joueur = joueurs[0]
            let suivant = joueursEnJeu.first(where: { $0.ordre == joueur.suivant})
            suivant!.mort = true
            joueur.mort = false
            let joueurPrecedent = joueur
            
            if joueurs.count == 2 {
                let joueur = joueurs[1]
                let suivant = joueursEnJeu.first(where: { $0.ordre == joueur.suivant})
                suivant!.mort = true
                joueur.mort = joueur.ordre == joueurPrecedent.suivant
            }
            return true
        } else {
            return true
        }
    }
    
    
    /// Vérifie si le nombre d'éléments la table passée en paramètre et compris entre le nombre minimal et maximal de joueurs autorisés.
    ///
    /// - parameter joueursTab: Requis, table à vérifier.
    /// - returns: Vrai si la table répond aux conditions.
    static func isCorrectNbJoueurs(nbJoueurs: Any) -> Bool {
        var nombre: Int = 0
        if let nb = nbJoueurs as? Int {
            nombre = nb
        } else if let tab = nbJoueurs as? [Joueur] {
            nombre = tab.count
        }
        return nombre >= GestionJoueurs.nbMiniJoueurs && nombre <= GestionJoueurs.nbMaxiJoueurs
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
        init(nb: Int, idx: Int) {
            _nb = nb
            _ordre = idx + 1
        }
        
        var ordre: Int {
            return _ordre
        }
        var idx: Int {
            return _ordre - 1
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
    
}
/*
 - 3 joueurs : 300
 simple
 
 - 4 joueurs : 400, 401
 simple
 3 simple + 1 mort
 
 - 5 joueurs : 502, 501, 510
 3 simple + 2 morts
 4 simple + 1 mort
 5 duo
 
 - 6 joueurs : 602, 611, 620
 4 simple + 2 morts
 5 duo + 1 mort
 (6 equipe)
 
 - 7 joueurs : 712, 721
 5 duo + 2 morts
 (6 equipe + 1 mort)
 
 - 8 joueurs : 822
 (6 equipe + 2 morts)
 
 >>> Soit : 3 modes de jeux (simple, duo, équipe)
 */

// Une fois choisi, le mode reste le même, malgré les joueurs hors jeu possible.
enum ModeJeu: Int {
    
    /// Le mode simple est le mode normal, 1 preneur contre le reste des joueurs.
    case simple = 0
    /// Le mode duo est le mode dans lequel le preneur appelle un partenaire (appel d'un roi).
    case duo
    /// Le mode équipe se joue avec 3 équipes de 2 joueurs, le partenaire est fixe (face à face).
    case equipe
    
    var nom: String {
        switch self {
        case .simple: return "Simple"
        case .duo: return "Duo"
        case .equipe: return "Equipe"
        }
    }
    var nbJoueurs: (min: Int, max: Int) {
        switch self {
        case .simple: return (3, 6)
        case .duo: return (5, 7)
        case .equipe: return (6, 8)
        }
    }

    static func nbMorts(modeChoix: Int) -> [Int: Int] {
        switch modeChoix {
        case 0: return [5: 1, 6: 2]
        case 1: return [5: 0, 6: 1, 7: 2]
        case 2: return [5: 0, 6: 0, 7: 1, 8: 2]
        default: break
        }
        return [:]
    }
    static func modeChoix(nbMorts: Int) -> [Int: Int] {
        switch nbMorts {
        case 0: return [4: 0, 5: 1, 6: 2]
        case 1: return [4: 0, 5: 0, 6: 1, 7: 2]
        case 2: return [5: 0, 6: 0, 7: 2, 8: 2]
        default: break
        }
        return [:]
    }
}



