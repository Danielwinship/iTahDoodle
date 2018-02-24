//
//  MasterListVC.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import CoreData

class MasterListVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemTextField: UITextField!
    
    //Variables
    var masterItemsArray = [Item]()
    var addItemArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        itemTextField.returnKeyType = UIReturnKeyType.done
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataServices.instance.fetch(completion: { (success) in
            if success {
                print("successfully fetched items")
                self.masterItemsArray.removeAll()
            }
        }) { (returnedItemsArray) in
            
            for returnedItem in returnedItemsArray {
                if returnedItem.activeList == false {
                   self.masterItemsArray.append(returnedItem)
                }
            }
        }
        
        
    }
    
    
    
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func itemTextFieldUsed(_ sender: Any) {
        if itemTextField.text != "" {
           
            DataServices.instance.save(itemName: itemTextField.text!, activeList: true, completion: { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            })
        }
    }
  
    
    
    
    
}

extension MasterListVC: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterListCell") as? MasterListCell else {return UITableViewCell()}
        if masterItemsArray[indexPath.row].name == itemTextField.text {
            cell.setupView(item: masterItemsArray[indexPath.row])
        }else {
           cell.setupView(item: masterItemsArray[indexPath.row])
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedItem = masterItemsArray[indexPath.item]
        DataServices.instance.update(objectId: selectedItem.objectID, active: true, completion: { (complete) in
            if complete {
                dismiss(animated: true, completion: nil)
            }
        })
        
    }
    
}






