//
//  ViewController.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 10/4/17.
//  Copyright © 2017 Daniel Winship. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    //@IBOutlet var itemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let todoList = ToDoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.textLabel?.textColor = UIColor.red
        
        //tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.red
        todoList.itemsToBeDeleted.append(indexPath.row)
        //print(todoList.itemsToBeDeleted.count)
        
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        todoList.remove()
        tableView.reloadData()
        
     
        
        
    }
    
    @IBAction func clearButton(_ sender: Any) {
        todoList.clear()
        tableView.reloadData()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("View loaded")
        todoList.loadItems(urlToUse: todoList.fileURL)
//        todoList.loadArrayForUse(nameOfArray: todoList.everyItemEverAdded, urlToUse: todoList.fileURLUsed)
        self.tableView.reloadData()
    }
 
  
    
    
  


}

