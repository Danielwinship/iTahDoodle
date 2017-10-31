//
//  ItemAdditionViewController.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 10/14/17.
//  Copyright © 2017 Daniel Winship. All rights reserved.
//

import UIKit
class ItemAdditionViewController: UIViewController, UITableViewDelegate{
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func textFieldPrimaryActionTrigger(_ sender: Any) {
        
        print("Add to-do item: \(itemTextField.text)")
                guard let item = itemTextField.text else {
                    return
                }
                if itemTextField.text == "" {
                    print("Text field is blank")
                    return
                }
        todoList.add(arrayToUse: todoList.everyItemEverAdded, item: item, url: todoList.fileURLUsed)
        todoList.add(arrayToUse: todoList.itemsToBeAdded, item: item, url: todoList.fileURL)
                //todoList.add(item, url: todoList.fileURL)
                //itemTextField.text = ""
                //tableView.reloadData()
        
                dismiss(animated: true, completion: nil)
               
                
        
    }
    
    
    var todoList = ToDoList()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.returnKeyType = UIReturnKeyType.done
        todoList.loadItems(urlToUse: todoList.fileURLUsed)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
    
               
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("Add to-do item: \(itemTextField.text)")
        guard let item = tableView.cellForRow(at: indexPath)?.textLabel?.text else {
            return
        }
//
//        if todoList.everyItemEverAdded.contains(item) {
//            return
//        }
       
//        todoList.add(arrayToUse: todoList.everyItemEverAdded, item: item, url: todoList.fileURLUsed)
        todoList.add(arrayToUse: todoList.itemsToBeAdded, item: item, url: todoList.fileURL)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}





