//
//  Partie.swift
//  Tarot
//
//  Created by Serge Gori on 12/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class Partie: NSManagedObject {
    
    static func all(TrierPar key: String = "idPartie", OrdreAscendant ascending: Bool = false) -> [Partie] {
        let request: NSFetchRequest<Partie> = Partie.fetchRequest()
        let tri = NSSortDescriptor(key: key, ascending: ascending)
        request.sortDescriptors = [tri]
        guard let parties = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return parties
    }
    
    
     func insert(Participants  joueurs: [PersonneCell], idPartie: Int, hD: Date, idxDonneur: Int, idxMort: [Int], modeJeu: ModeJeu) -> Bool? {
//        static func insert(Participants  joueurs: [PersonneCell], idPartie: Int, hD: Date, idxDonneur: Int, idxMort: [Int], modeJeu: ModeJeu) -> Bool? {

        let partie = Partie(context: AppDelegate.viewContext)
        let type = joueurs.count * 100 + modeJeu.rawValue * 10 + idxMort.count
        partie.idPartie = Int32(idPartie)
        partie.horodate = hD
        partie.type = Int16(type)
        
        for participant in joueurs {
            let joueur = Joueur(context: AppDelegate.viewContext)
            joueur.idJoueur = Int16(participant.idJoueurLabel.text!)!
            joueur.ordre = Int16(participant.idx)
            joueur.suivant = Int16(participant.suivant)
            joueur.points = 0.0
            joueur.enJeu = true
            joueur.donneur = participant.idx == idxDonneur
            joueur.mort = idxMort.contains(participant.idx)
            
            partie.addToParticipants(joueur)
        }
        
        return Partie.save()
    }
    
    
     func update(Jeu jeuComplet: JeuComplet, idJeu: Int, hD: Date, gj: GestionJoueurs) -> Bool {
//        static func update(_ partie: Partie, Jeu jeuComplet: JeuComplet, idJeu: Int, hD: Date, gj: GestionJoueurs) -> Bool {

        let jeuResultat = JeuResultat(context: viewContext)        
        jeuResultat.idJeu = Int64(idJeu)
        jeuResultat.horodate = hD
        jeuResultat.contrat = Int16(jeuComplet.contrat!)
        jeuResultat.nbBout = Int16(jeuComplet.nbBout!)
        jeuResultat.pointsFaits = jeuComplet.pointsFaits!
        jeuResultat.petitAuBout = Int16(jeuComplet.petitAuBout)
        jeuResultat.poignee = Int16(jeuComplet.poignee)
        jeuResultat.chelem = Int16(jeuComplet.chelem)
        jeuResultat.total = jeuComplet.total!
        jeuResultat.idPartie = self.idPartie
        
        for participant in gj.joueursPartie {
            if let infosJeuJoueurs = gj.infosJeuJoueurs?.first(where: { participant.idJoueur == $0.idJoueur }) {
                let jeuJoueur = JeuJoueur(context: AppDelegate.viewContext)
                jeuJoueur.idJoueur = Int16(participant.idJoueur)
                jeuJoueur.idJeu = Int64(idJeu)
                jeuJoueur.classement = Int16(participant.classement)
                jeuJoueur.points = infosJeuJoueurs.points
                jeuJoueur.etat = infosJeuJoueurs.etat!.rawValue
                
                jeuResultat.addToJoueurs(jeuJoueur)
            }
        }
        
        self.addToJeux(jeuResultat)
        
        return Partie.save()
    }
    
    
    static func save() -> Bool {
        do {
            try AppDelegate.viewContext.save()
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
