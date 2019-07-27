//
//  Personne.swift
//  Tarot
//
//  Created by Serge Gori on 01/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class Personne: NSManagedObject {
    
    static func all(TrierPar tri: String = "surnom") -> [Personne] {
        let request: NSFetchRequest<Personne> = Personne.fetchRequest()
        let tri = NSSortDescriptor(key: tri, ascending: true)
        request.sortDescriptors = [tri]
        
        guard let joueurs = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return joueurs
    }
    
    static func joueurPartie(idJoueurs: [Int]) -> [Personne] {
        let request: NSFetchRequest<Personne> = Personne.fetchRequest()
        // Définition de tri de la requête
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        request.sortDescriptors = [tri]
        // Définition du filtre de la requête
        var filter = String()
        for item in idJoueurs {
            filter += item == idJoueurs.last ? "idJoueur == \(item)" : "idJoueur == \(item) OR "
        }
        request.predicate = NSPredicate(format: filter)
        
        guard let joueurs = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return joueurs
    }
    
    
}

