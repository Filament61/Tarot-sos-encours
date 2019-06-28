//
//  PointsJeu.swift
//  Tarot
//
//  Created by Serge Gori on 25/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class PointsJeu: NSManagedObject {
    
    static var all: [PointsJeu] {
        let request: NSFetchRequest<PointsJeu> = PointsJeu.fetchRequest()
        guard let pointsJeux = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return pointsJeux
    }
    
    static func save(scoreJeu jeuComplet: JeuComplet) {
        let pointsJeu = PointsJeu(context: AppDelegate.viewContext)
        
        pointsJeu.contrat = Int16(jeuComplet.contrat!)
        pointsJeu.nbBout = Int16(jeuComplet.nbBout!)
        pointsJeu.pointsFaits = jeuComplet.pointsFaits!
        pointsJeu.petitAuBout = Int16(jeuComplet.petitAuBout)
        pointsJeu.poignee = Int16(jeuComplet.poignee)
        pointsJeu.chelem = Int16(jeuComplet.chelem)
        pointsJeu.total = jeuComplet.total ?? 0.0
        
        do {
            try? AppDelegate.viewContext.save()
        }
        catch {
            
        }

    }
}
