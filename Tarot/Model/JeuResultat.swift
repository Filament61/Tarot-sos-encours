//
//  JeuResultatTable.swift
//  Tarot
//
//  Created by Serge Gori on 25/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class JeuResultat: NSManagedObject {
    
    static func all(TrierPar tri: String = "idJeu") -> [JeuResultat] {
        let request: NSFetchRequest<JeuResultat> = JeuResultat.fetchRequest()
        let tri = NSSortDescriptor(key: tri, ascending: false)
        request.sortDescriptors = [tri]
        guard let jeuResultats = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return jeuResultats
    }
    
    static func jeuResultat(idJeux: [Int64]) -> [JeuResultat] {
        let request: NSFetchRequest<JeuResultat> = JeuResultat.fetchRequest()
        // Définition de tri de la requête
        let tri = NSSortDescriptor(key: "idJeu", ascending: false)
        request.sortDescriptors = [tri]
        // Définition du filtre de la requête
        var filter = String()
        for item in idJeux {
            filter += item == idJeux.last ? "idJeu == \(item)" : "idJeu == \(item) OR "
        }
        request.predicate = NSPredicate(format: filter)
        
        guard let jeuResultats = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return jeuResultats
    }
    
    static func save(scoreJeu jeuComplet: JeuComplet, idJeu: Int, hD: Date) {
        
        let jeuResultat = JeuResultat(context: AppDelegate.viewContext)
        
        jeuResultat.idJeu = Int64(idJeu)
        jeuResultat.horodate = hD
        jeuResultat.contrat = Int16(jeuComplet.contrat!)
        jeuResultat.nbBout = Int16(jeuComplet.nbBout!)
        jeuResultat.pointsFaits = jeuComplet.pointsFaits!
        jeuResultat.petitAuBout = Int16(jeuComplet.petitAuBout)
        jeuResultat.poignee = Int16(jeuComplet.poignee)
        jeuResultat.chelem = Int16(jeuComplet.chelem)
        jeuResultat.total = jeuComplet.total ?? 0.0
        
        do {
            try AppDelegate.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }

    }
    
}
