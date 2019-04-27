//
//  ViewController.swift
//  Todoy
//
//  Created by Abdelbari on 4/16/19.
//  Copyright © 2019 Abdelbari. All rights reserved.
//

import UIKit

class TodoyViewController: UITableViewController {

    var todoArray = [Item]()
    var userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Make lock screen wallpapers android app"
        todoArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Make 3 T-shirts on Amazon"
        todoArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Learn Ios Developement"
        todoArray.append(newItem3)
         
        
        
        if  let items : [Item] = userDefault.array(forKey: "toDoListArray") as? [Item]{

            todoArray = items

        }
        
    }

    
    // Table View easy peasy stuff
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAtindexPath Called")
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "todoycellitem", for: indexPath)
        
        let item = todoArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        
     cell.accessoryType = item.done ? .checkmark : .none
        
   
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
        tableView.reloadData()
        
        }
    
  // Mark -- add todoey item
    
//    
    @IBAction func todoyAddPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add your item", style: .default) { (action) in
            print(textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
          self.todoArray.append(newItem)
            self.userDefault.set(self.todoArray, forKey: "toDoyarray")
            
           self.tableView.reloadData()
        
            
            
        }
      
        alert.addTextField {(ItemTextField) in
            ItemTextField.placeholder="Type your item"
            textField = ItemTextField
        }

        alert.addAction(action)
        
     
       
        
        present(alert, animated: true, completion: nil)
        
   }
    
    
    
}

