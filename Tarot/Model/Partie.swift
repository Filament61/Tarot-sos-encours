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
    
    static func save(scoreJeu jeuComplet: JeuComplet, idPartie: Int, hD: Date) {
        
        let partie = Partie(context: AppDelegate.viewContext)
        
        partie.idPartie = Int32(idPartie)
        partie.horodate = hD
        
        
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

}
