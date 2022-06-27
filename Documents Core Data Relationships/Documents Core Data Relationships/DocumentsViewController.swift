//
//  DocumentsViewController.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 10/2/20.
//

import UIKit
import CoreData

class DocumentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    var category: Category?
    var documents = [Document]()
    let dateFormat = DateFormatter()
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentsTableView.delegate = self
        documentsTableView.dataSource = self
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.documentsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.documents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentC", for: indexPath)
        
        if let document = category?.documents?[indexPath.row]{
            cell.textLabel?.text = document.name
            
            if let modifiedDate = document.rawDate {
                cell.detailTextLabel?.text = dateFormat.string(from: modifiedDate)
            }
        
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else {
            return
        }
        
        if segue.identifier == "newDoc"{
            destination.category = category
        }
        
        if segue.identifier == "existingDoc" {
            if let row = documentsTableView.indexPathForSelectedRow?.row {
                destination.document = category?.documents?[row]
            }
        }
        
    }

    @IBAction func addNewDocument(_ sender: Any) {
        performSegue(withIdentifier: "newDoc", sender: self)
    }
    
    
    
    func deleteDocument(at indexPath: IndexPath){
        guard let document = category?.documents?[indexPath.row],
              let managedContext = document.managedObjectContext else {
                return
        }
        
        managedContext.delete(document)
        
        do{
            try managedContext.save()
            
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Could not delete Document")
            
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
    
}
