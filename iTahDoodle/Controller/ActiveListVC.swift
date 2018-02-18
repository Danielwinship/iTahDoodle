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
    var itemsArray = [Item]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
        
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
    

    
    
  
    
    
    @IBAction func menuButtonWasPressed(_ sender: Any) {
      
        
    }
    

}

extension ActiveListVC:UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ActiveListCell" ) as? ActiveListCell else {return UITableViewCell()}
        cell.setupView(item: itemsArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let removeActiveItem = itemsArray[indexPath.row]
        removeActiveItem.activeList = false
        print("\(removeActiveItem.activeList)")
        tableView.reloadData()
    }
    
    
}











