//
//  DataServices.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class DataServices {
    
    static let instance = DataServices()

    
  
    
    func fetch(completion: (_ complete: Bool) -> (),handler:@escaping (_ itemsArray: [Item]) -> ()) {
         var items = [Item]()
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        
        do{
            items = try  managedContext.fetch(fetchRequest)
            print("Successfully fetched data")
            completion(true)
            handler(items)
            
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    func save(itemName name: String, activeList active: Bool, completion:( _ finished:Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let item = Item(context: managedContext)
        
        item.name = name
        item.activeList = active
        
        
        do {
            try managedContext.save()
            
            print("Successfully saved data")
            completion(true)
        }catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func update(itemName name:String, active:Bool, completion:(_ finished:Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        fetchRequest.predicate = predicate
        do{
            let fetchedItem = try  managedContext.fetch(fetchRequest)
            if fetchedItem.count != 0 {
               fetchedItem.first?.activeList = active
                try managedContext.save()
                print("Successfully updated record")
                completion(true)
            }
        }catch {
            debugPrint("Could not update record \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
  
    
    
    
}
