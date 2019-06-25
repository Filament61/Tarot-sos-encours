//
//  NSManagedObjectExtension.swift
//  Tarot
//
//  Created by Serge Gori on 25/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import CoreData



extension NSManagedObject {
    
    static func nextAvailble(_ idKey: String, forEntityName entityName: String, inContext context: NSManagedObjectContext) -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        fetchRequest.propertiesToFetch = [idKey]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: idKey, ascending: true)]
        
        do {
            let results = try context.fetch(fetchRequest)
            let lastObject = (results as! [NSManagedObject]).last
            
            guard lastObject != nil else {
                return 1
            }
            
            return lastObject?.value(forKey: idKey) as! Int + 1
            
        } catch let error as NSError {
            //handle error
        }
        
        return 1
    }
    
}
