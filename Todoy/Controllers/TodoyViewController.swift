//
//  ViewController.swift
//  Todoy
//
//  Created by Abdelbari on 4/16/19.
//  Copyright © 2019 Abdelbari. All rights reserved.
//

import UIKit
import CoreData
class TodoyViewController: UITableViewController {

    var todoArray = [Item]()
    var userDefault = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       loadData()
        
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
       
       context.delete(todoArray[indexPath.row])
        todoArray.remove(at:indexPath.row)

        tableView.deselectRow(at: indexPath, animated: true)
        
     //   todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
        
        saveData()

        
        }
    
  // Mark -- add todoey item
    
//    
    @IBAction func todoyAddPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add your item", style: .default) { (action) in
            print(textField.text!)
      
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
          self.todoArray.append(newItem)
            self.saveData()
       
            
            
        }
      
        alert.addTextField {(ItemTextField) in
            ItemTextField.placeholder="Type your item"
            textField = ItemTextField
        }

        alert.addAction(action)
        
     
       
        
        present(alert, animated: true, completion: nil)
        
   }
    
    func saveData(){
        
      
        do {
            try context.save()
            
        }
        catch {
            print("error while saving data\(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    func loadData(with request:NSFetchRequest<Item>=Item.fetchRequest()){
        
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{ todoArray = try context.fetch(request)
        }
        catch {
            
            print("error while fetching Data\(error)")
        }
        
       tableView.reloadData()
    }
    
   
    
    
}

extension   TodoyViewController : UISearchBarDelegate {
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
       loadData(with: request)
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    loadData()
}
}
