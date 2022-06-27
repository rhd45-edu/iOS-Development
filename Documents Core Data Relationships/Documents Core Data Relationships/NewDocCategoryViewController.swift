//
//  NewDocCategoryViewController.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 10/2/20.
//

import UIKit

class NewDocCategoryViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
    }
        
        @IBAction func newCategorySave(_ sender: Any) {
            let category = Category(title: titleTextField.text ?? "")

            do{
                try category?.managedObjectContext?.save()

                self.navigationController?.popViewController(animated: true)
            } catch {
                let alert = UIAlertController(title: "alert", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
    }
}
