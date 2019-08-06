//
//  GestionJoueurs.swift
//  Tarot
//
//  Created by Serge Gori on 30/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import Foundation

class GestionJoueurs {
    
    static let nbMiniJoueurs = 3
    static let nbMaxiJoueurs = 8
    
    
    init(joueurs: [Joueur], NouvellePartie isNouvellePartie: Bool) {
        self._joueursPartie = joueurs
        self._joueursPartie.sort(by: { $0.ordre < $1.ordre })
        self._joueursEnJeu = self._joueursPartie.filter({ $0.enJeu == true})
        self._joueursEnMene = self._joueursEnJeu.filter({ $0.mort == false})
 }
    
    var nbJoueursPartie: Int { return self._nbJoueursPartie }
    var joueursPartie: [Joueur]
    {
        return _joueursPartie
    }
    
    var nbJoueursEnMene: Int { return self._nbJoueursEnMene }
    var joueursEnMene: [Joueur] { return self._joueursEnMene }
    
    var nbJoueursEnjeu: Int { return self._nbJoueursEnJeu }
    var joueursEnJeu: [Joueur] { return self._joueursEnJeu }
    
    private var _nbJoueursPartie: Int = 0
    private var _joueursPartie: [Joueur]
//    {
//        didSet { _nbJoueursPartie = self._joueursPartie.count }
//    }
    
    private var _nbJoueursEnMene: Int = 0
    private var _joueursEnMene: [Joueur] {
        didSet { _nbJoueursEnMene = self._joueursEnMene.count }
    }
    
    private var _nbJoueursEnJeu: Int = 0
    private var _joueursEnJeu: [Joueur] {
        didSet { _nbJoueursEnJeu = self._joueursEnJeu.count }
    }
    
    var joueursDefense = [Joueur]()
    
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
    
    func affecterPoints(points: Float, jjj: [Joueur]) {
        /// MARK: Faire le calcul du coefficient
        let coef: Float = Float(nbJoueursEnMene.minus())
        
        guard let preneur = self.preneur else { return }
        let idx = _joueursPartie.firstIndex(of: preneur)!
        var toto : Float = 0.0
        toto = toto + points * 2.0
        var jj = self._joueursPartie[idx]
        jjj[0].points = points
        let tata = jj.points
        _joueursPartie[3].points = _joueursPartie[3].points + (points * coef)
        //        self.joueursDefense = self.joueursEnMene.filter { $0.idJoueur != preneur.idJoueur }
        joueursDefense = _joueursPartie.filter { $0.idJoueur != preneur.idJoueur }
        
        
        if let partenaire = self.partenaire, let idx = self.joueursPartie.firstIndex(of: partenaire) {
            self._joueursPartie[idx].points += points
            self.joueursDefense = self.joueursDefense.filter { $0.idJoueur != partenaire.idJoueur }
        }
        
        for joueur in self.joueursDefense {
            if let idx = self._joueursPartie.firstIndex(of: joueur) {
                self._joueursPartie[idx].points -= points
            }
        }
        
        return
    }
    
//    func affecterPoints(joueurs: [Joueur], points: Float) -> [Joueur] {
//        // MARK: Faire le calcul du coefficient
//        let coef: Float = 3.0
//        guard let preneur = preneur else { return joueurs }
//        let joueursEnCours = joueurs
//        for joueur in joueursEnCours {
//            if joueur.ordre == Int16(preneur) {
//                joueur.points += points * coef // nb joueurs restants
//            } else if let partenaire = partenaire {
//                if joueur.ordre == Int16(partenaire) {
//                    joueur.points += points // nb joueurs restants
//                }
//            } else if joueur.enJeu && !joueur.mort {
//                joueur.points -= points // nb joueurs restants
//            }
//        }
//        return joueursEnCours
//    }

    func donneSuivante(joueurs: [Joueur]) -> [Joueur] {
        var joueursSuivants = joueurs
        
        // On vérifie qu'il existe au moins 1 joueur en jeu !
        guard let _ = joueurs.firstIndex(where: {$0.enJeu == true}) else { return joueurs }
        // On vérifie qu'il existe au moins 1 donneur identifié
        if let idxDonneur = joueurs.firstIndex(where: {$0.donneur == true}) {
            if let idx = joueurs.firstIndex(where: {$0.donneur == true && $0.enJeu == true}) {
                let donneur = varCirculaire(nb: joueurs.count, idx: idx)
                repeat {
                    let _ = donneur.suivant()
                } while (joueurs[donneur.idx].enJeu == false)
                
                
                joueursSuivants[idxDonneur].donneur = false
                joueursSuivants[donneur.idx].donneur = true
            }
        } else if let idxEnJeu = joueurs.firstIndex(where: {$0.enJeu == true}) {
            let donneur = varCirculaire(nb: joueurs.count, idx: idxEnJeu)
            let _ = donneur.suivant()
            joueursSuivants[donneur.idx].donneur = true
        }


        return joueursSuivants
    }
  
    
    
    
    /// Vérifie si le nombre d'éléments la table passée en paramètre et compris entre le nombre minimal et maximal de joueurs autorisés.
    ///
    /// - parameter joueursTab: Requis, table à vérifier.
    /// - returns: Vrai si la table répond aux conditions.
    private func isCorectNbJoueurs(joueursTab: [Joueur]?) -> Bool {
        guard let joueursTab = joueursTab else { return false }
        return joueursTab.count >= GestionJoueurs.nbMiniJoueurs && joueursTab.count >= GestionJoueurs.nbMaxiJoueurs
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

enum ModeJeu: String {
    /// Le mode simple est le mode normal, 1 preneur contre le reste des joueurs.
    case simple
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
    var choix: Int {
        switch self {
        case .simple: return 0
        case .duo: return 1
        case .equipe: return 2
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

enum Contrat: String {
    case petite, garde, gardeSans, gardeContre
    
    var nom: String {
        switch self {
        case .petite: return "Petite"
        case .garde: return "Garde"
        case .gardeSans: return "Garde sans"
        case .gardeContre: return "Garde contre"
            //        default: break
        }
    }
    var abv: String {
        switch self {
        case .petite: return "P"
        case .garde: return "G"
        case .gardeSans: return "GS"
        case .gardeContre: return "GC"
            //        default: break
        }
    }
    var idx: Int {
        switch self {
        case .petite: return 1
        case .garde: return 2
        case .gardeSans: return 3
        case .gardeContre: return 4
//        default: break
        }
    }

}


