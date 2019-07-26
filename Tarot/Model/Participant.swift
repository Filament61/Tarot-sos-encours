//
//  Participant.swift
//  Tarot
//
//  Created by Serge Gori on 12/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData

class Participant: NSManagedObject {
    
    static func all(TrierPar tri: String = "idJoueur") -> [Participant] {
        let request: NSFetchRequest<Participant> = Participant.fetchRequest()
        let tri = NSSortDescriptor(key: tri, ascending: true)
        request.sortDescriptors = [tri]
        
        guard let participants = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return participants
    }
    
}
