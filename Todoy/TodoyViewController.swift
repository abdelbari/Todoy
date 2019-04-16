//
//  ViewController.swift
//  Todoy
//
//  Created by Abdelbari on 4/16/19.
//  Copyright © 2019 Abdelbari. All rights reserved.
//

import UIKit

class TodoyViewController: UITableViewController {

    var todoArray = ["Make new wallpapers","Make 3 shirts","check admob"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // Table View easy peasy stuff
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: "todoycellitem")
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoArray[indexPath.row])
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
  // Mark -- add todoey item
    
//    
    @IBAction func todoyAddPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add your item", style: .default) { (action) in
            print(textField.text!)
           self.todoArray.append(textField.text!)
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

