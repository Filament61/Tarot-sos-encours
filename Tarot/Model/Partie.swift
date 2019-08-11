//
//  Partie.swift
//  Tarot
//
//  Created by Serge Gori on 12/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class Partie: NSManagedObject {
    
    static func all(TrierPar tri: String = "idPartie") -> [Partie] {
        let request: NSFetchRequest<Partie> = Partie.fetchRequest()
        let tri = NSSortDescriptor(key: tri, ascending: false)
        request.sortDescriptors = [tri]
        guard let Parties = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return Parties
    }
    
    static func inset(Participants  joueurs: [PersonneCell], idPartie: Int, hD: Date, idxDonneur: Int, idxMort: [Int], modeJeu: ModeJeu) {
//        static func save(_ partie: Partie, participants: [PersonneCell], idPartie: Int, hD: Date, donneur: Int, mort: Int) {

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

        
        //        if let deletable = participants.array as? [Joueur] {
        //            AppDelegate.viewContext.delete(deletable)
        //        }
        
        //        jeuResultat.contrat = Int16(jeuComplet.contrat!)
        //        jeuResultat.nbBout = Int16(jeuComplet.nbBout!)
        //        jeuResultat.pointsFaits = jeuComplet.pointsFaits!
        //        jeuResultat.petitAuBout = Int16(jeuComplet.petitAuBout)
        //        jeuResultat.poignee = Int16(jeuComplet.poignee)
        //        jeuResultat.chelem = Int16(jeuComplet.chelem)
        //        jeuResultat.total = jeuComplet.total ?? 0.0
        
        do {
            try AppDelegate.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    static func update(_ partie: Partie, Jeu jeuComplet: JeuComplet, idJeu: Int, hD: Date, participants: [Joueur], mort: Int) -> Bool {
        
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
                
        for participant in participants {
            let jeuJoueur = JeuJoueur(context: AppDelegate.viewContext)
            jeuJoueur.idJoueur = Int16(participant.idJoueur)
            jeuJoueur.etat = Int16(2)
            jeuJoueur.idJeu = Int64(idJeu)
            
            jeuResultat.addToJoueurs(jeuJoueur)
        }

        
        partie.addToJeux(jeuResultat)
        
        do {
            try AppDelegate.viewContext.save()
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
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
