//
//  NewDocumentViewController.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 10/2/20.
//

import UIKit

class NewDocumentViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var documentTitle: UINavigationItem!
    @IBOutlet weak var documentContent: UITextView!
    @IBOutlet weak var titleEntered: UITextField!
    @IBOutlet weak var tripImage: UIImageView!
    
    var category: Category?
    var document: Document?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let document = document{
            documentTitle.title = document.name
            titleEntered.text = document.name
            documentContent.text = document.content
            
        }
        
        
    }
    @IBAction func showImagePicker(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        let name = documentTitle.title
        let context = documentContent.text ?? ""
        
        if name == "" {
            let alert = UIAlertController(title: "Trip Could not Be Saved", message: "Please title this Trip", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        if document == nil {
            document = Document(name: name, content: context)
        }else{
            document?.updateDoc(name: name, content: context)
        }
        
        
        if let document = document {
            category?.addToRawDocuments(document)
            do{
                let managedContext = document.managedObjectContext
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }catch {
                print("Trip was not saved")
            }
        }
    }
    
    
    @IBAction func nameChange(_ sender: Any) {
        documentTitle.title = titleEntered.text
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            picker.dismiss(animated: true)
            
            guard let image = info[.editedImage] as? UIImage else {
                print("No Image Found")
                return
            }
            
        tripImage.image = image
}

}
