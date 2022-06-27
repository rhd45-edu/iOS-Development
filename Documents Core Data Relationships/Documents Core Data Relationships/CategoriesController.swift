//
//  ViewController.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 9/30/20.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentCategoriesView.delegate = self
        documentCategoriesView.dataSource = self
        documentCategoriesView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        
    }

    @IBOutlet weak var documentCategoriesView: UITableView!
    
    var categories: [Category] = []
    var documents: [Document] = []
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
            }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try managedContext.fetch(fetchRequest)
            
            documentCategoriesView.reloadData()
        } catch {
            print("Could not fetch")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DocumentsViewController,
              let segueIdentifier = segue.identifier, segueIdentifier == "categorySegue",
                let selectedRow = self.documentCategoriesView.indexPathForSelectedRow?.row  else {
                return
            }
            
        destination.category = categories[selectedRow]
        }
    
    func deleteCategory(at indexPath: IndexPath){
        let category = categories[indexPath.row]
        
        guard let managedContext = category.managedObjectContext else {
            return
        }
        
        managedContext.delete(category)
        
        do {
            try managedContext.save()
            
            categories.remove(at: indexPath.row)
            
            documentCategoriesView.deleteRows(at: [indexPath], with: .automatic)
        }catch {
            print("Could not delete")
            
            documentCategoriesView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
           }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = documentCategoriesView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

                let category = categories[indexPath.row]

                cell.textLabel?.text = category.title

                return cell
           }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "categorySegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        
            
            let alert = UIAlertController(title: "Are you sure?", message: "This action will delete the category and it's corresponding documents", preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {action in
                self.deleteCategory(at: indexPath)
            }))
            
            self.present(alert, animated: true)
        }
    }

}
    
    
    
       


