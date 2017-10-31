//
//  ToDoList.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 10/6/17.
//  Copyright © 2017 Daniel Winship. All rights reserved.
//

import UIKit

class ToDoList: NSObject {
     let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("todolist.items")
    }()
    
    
     let fileURLUsed: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("todolistUsed.items")
    }()
    
    
    fileprivate var items: [String] = []
     var itemsToBeDeleted: [Int] = []
     var itemsToBeAdded: [String] = []
     var everyItemEverAdded: [String] = []
    
    func saveItems(_ items:[String], urlToUse:URL)  {
        let itemsArray = items as NSArray
        
        print("Saving items to \(urlToUse)")
        
        if !itemsArray.write(to: urlToUse, atomically: true) {
            print("Could not save to-do list")
        }
         //loadArrayForUse()
    }
    
    func loadItems(urlToUse:URL)  {
          items.removeAll()
        if let itemsArray = NSArray(contentsOf: urlToUse) as? [String] {
            items = itemsArray
        }
    }
    
    
    override init() {
        super.init()
        loadItems(urlToUse: fileURL)
        loadEveryItemEverAdded()
        loadItemsToBeAdded()
        
    }
    
   func loadEveryItemEverAdded() {
 if let itemsArray = NSArray(contentsOf: fileURLUsed) as? [String] {
    everyItemEverAdded = itemsArray
    
        }
   }
    func loadItemsToBeAdded() {
        if let itemsArray = NSArray(contentsOf: fileURL) as? [String] {
            itemsToBeAdded = itemsArray
            
        }
    }
    
  
    
   
    
    func add(arrayToUse:[String], item: String, url:URL) {
        
        var arrayToUse = arrayToUse
        arrayToUse.append(item)
        saveItems(arrayToUse, urlToUse: url)
        
    }
    func remove() {
        itemsToBeDeleted.sort()
        if itemsToBeDeleted.count != 0 {
            for i in itemsToBeDeleted.reversed() {
            items.remove(at:i)
            saveItems(items, urlToUse: fileURL)
            }
       }
         itemsToBeDeleted.removeAll()
    }
   
    
    func clear() {
        items.removeAll()
        saveItems(items, urlToUse: fileURL)
    }
    
    

}



extension ToDoList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item
        cell.textLabel?.textColor = UIColor.black
        return cell
        
        
        
    }
    
    
    
}
