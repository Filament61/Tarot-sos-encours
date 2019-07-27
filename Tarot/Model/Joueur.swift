//
//  Participant.swift
//  Tarot
//
//  Created by Serge Gori on 12/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class Joueur: NSManagedObject {
    
    static func all(TrierPar tri: String = "ordre") -> [Joueur] {
        let request: NSFetchRequest<Joueur> = Joueur.fetchRequest()
        let tri = NSSortDescriptor(key: tri, ascending: true)
        request.sortDescriptors = [tri]
        
        guard let participants = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return participants
    }
    
    //    static func joueurPartie(idPartie: [Int]) -> [Participant] {
    //        let request: NSFetchRequest<Participant> = Participant.fetchRequest()
    //        // Définition de tri de la requête
    //        let tri = NSSortDescriptor(key: "nom", ascending: true)
    //        request.sortDescriptors = [tri]
    //        // Définition du filtre de la requête
    //        var filter = String()
    //        for item in idJoueurs {
    //            filter += item == idJoueurs.last ? "idJoueur == \(item)" : "idJoueur == \(item) OR "
    //        }
    //        request.predicate = NSPredicate(format: filter)
    //
    //        guard let joueurs = try? AppDelegate.viewContext.fetch(request) else { return [] }
    //        return joueurs
    //    }
    
    
}
