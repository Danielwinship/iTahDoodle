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
    var itemsArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        itemTextField.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataServices.instance.fetch(completion: { (success) in
            if success {
                print("successfully fetched items")
            }
        }) { (returnedItemsArray) in
            self.itemsArray = returnedItemsArray
        }
        
        tableView.reloadData()
    }
    
//    func save(completion:( _ finished:Bool) -> ()) {
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//        let item = Item(context: managedContext)
//
//        item.name = itemTextField.text
//        item.activeList = true
//
//
//        do {
//            try managedContext.save()
//            print("Successfully saved data")
//            completion(true)
//        }catch {
//            debugPrint("Could not save \(error.localizedDescription)")
//            completion(false)
//        }
//    }
    
    
    
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
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterListCell") as? MasterListCell else {return UITableViewCell()}
        cell.setupView(item: itemsArray[indexPath.row])
        return cell
    }
    
    
}






