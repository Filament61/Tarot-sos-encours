//
//  JeuResultat.swift
//  Tarot
//
//  Created by Serge Gori on 25/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class JeuResultatTable: NSManagedObject {
    
    static var all: [JeuResultatTable] {
        let request: NSFetchRequest<JeuResultatTable> = JeuResultatTable.fetchRequest()
        guard let jeuResultats = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return jeuResultats
    }
    
    static func save(scoreJeu jeuComplet: JeuComplet) {
        let jeuResultatTable = JeuResultatTable(context: AppDelegate.viewContext)
        
        jeuResultatTable.contrat = Int16(jeuComplet.contrat!)
        jeuResultatTable.nbBout = Int16(jeuComplet.nbBout!)
        jeuResultatTable.pointsFaits = jeuComplet.pointsFaits!
        jeuResultatTable.petitAuBout = Int16(jeuComplet.petitAuBout)
        jeuResultatTable.poignee = Int16(jeuComplet.poignee)
        jeuResultatTable.chelem = Int16(jeuComplet.chelem)
        jeuResultatTable.total = jeuComplet.total ?? 0.0
        
        do {
            try? AppDelegate.viewContext.save()
        }
        catch {
            
        }

    }
}
