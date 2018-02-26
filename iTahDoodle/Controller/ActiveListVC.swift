//
//  ActiveListVC.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import CoreData

class ActiveListVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listNameLabel: UILabel!
    
    //Variables
    var activeItemsArray = [Item]()
    var removeItemsRow = [Int:Int]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataServices.instance.fetch(completion: { (success) in
            if success {
             print("successfully fetched items")
                self.activeItemsArray.removeAll()
            }
        }) { (returnedItemsArray) in
            for item in returnedItemsArray {
                if item.activeList == true {
                    self.activeItemsArray.append(item)
                }
                
            }
        }
        
        tableView.reloadData()
    }
    

    //functions
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let clear = UIAlertAction(title: "Clear", style: .destructive) { (action) in
            self.confirmClearActionAlert()
        }
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
           self.confirmDelteActionAlert()
        }
        
        actionSheet.addAction(delete)
        actionSheet.addAction(clear)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func confirmDelteActionAlert() {
        let actionAlert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "YES", style: .default) { (action) in
            self.removeItemsFromActiveItemsArray()
        }
        
        let no = UIAlertAction(title: "NO", style: .default) { (action) in
            
        }
        actionAlert.addAction(yes)
        actionAlert.addAction(no)
        present(actionAlert, animated: true, completion: nil)
    }
    
    func confirmClearActionAlert() {
        let actionAlert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "YES", style: .default) { (action) in
            self.removeAllItemsfromActiveItemsArray()
            
        }
        
        let no = UIAlertAction(title: "NO", style: .default) { (action) in
            
        }
        actionAlert.addAction(yes)
        actionAlert.addAction(no)
        present(actionAlert, animated: true, completion: nil)
    }
    
    func removeItemsFromActiveItemsArray() {
     let sortedRemoveItemsRow = removeItemsRow.sorted(by: >)
       
        if removeItemsRow.count != 0 {
           
            for i in sortedRemoveItemsRow {
                
                 let id = activeItemsArray[i.value].objectID
                
                DataServices.instance.update(objectId: id , active: false, completion: { (success) in
                    if success {
                      
                        activeItemsArray.remove(at: i.value)
                    }
                })
               
            }
        }else {
            return
        }
        removeItemsRow.removeAll()
        self.tableView.reloadData()
    }
    
    func removeAllItemsfromActiveItemsArray() {
        for item in activeItemsArray {
             let id = item.objectID
            DataServices.instance.update(objectId: id, active: false, completion: { (success) in
                if success {
                    activeItemsArray.removeAll()
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    
    @IBAction func menuButtonWasPressed(_ sender: Any) {
      showActionSheet()
    }
    

}

extension ActiveListVC:UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ActiveListCell" ) as? ActiveListCell else {return UITableViewCell()}
         let cellName  = activeItemsArray[indexPath.row].name
        let cellActive = activeItemsArray[indexPath.row].activeList
        cell.setupView(itemName: cellName!, itemActive: cellActive)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedActiveItem = activeItemsArray[indexPath.row]

        if selectedActiveItem.activeList == true {
             selectedActiveItem.activeList = false
            print("appending \(indexPath.item)")
            removeItemsRow.updateValue(indexPath.row, forKey: indexPath.row)
             self.tableView.reloadData()
        } else {
            selectedActiveItem.activeList = true
            //print("current count \(removeItemsRow.count)")
            print("removing \(indexPath.row)")
            
            removeItemsRow.removeValue(forKey: indexPath.row)
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
}











