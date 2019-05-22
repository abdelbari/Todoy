//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Abdelbari on 5/1/19.
//  Copyright © 2019 Abdelbari. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {

    var arrayOfCategories = [ItemCategory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
     override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellIItem", for : indexPath)
        let item = arrayOfCategories[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCategories.count
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoyViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = arrayOfCategories[indexPath.row]

        }
    }
    
    @IBAction func pressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add your item", style: .default) { (action) in
            print(textField.text!)
            
            let newItem = ItemCategory(context: self.context)
            newItem.name = textField.text!
            self.arrayOfCategories.append(newItem)
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
    
    
    func loadData(with request:NSFetchRequest<ItemCategory>=ItemCategory.fetchRequest()){
        
        // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{ arrayOfCategories = try context.fetch(request)
        }
        catch {
            
            print("error while fetching Data\(error)")
        }
        
        tableView.reloadData()
    }

}
