//
//  ViewController.swift
//  Todoy
//
//  Created by Abdelbari on 4/16/19.
//  Copyright © 2019 Abdelbari. All rights reserved.
//

import UIKit

class TodoyViewController: UITableViewController {

    let todoArray = ["Make new wallpapers","Make 3 shirts","check admob"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

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
    
    
    @IBAction func todoyAddPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "add your item", style: .default) { (action) in
            print("success!")
        }
        alert.addAction(action)
        
        alert.addTextField { (addItemTextField) in
            addItemTextField.placeholder="Type your item"
        }
        
       
        
        present(alert, animated: true) {
            
        }
    }
    
    
}

