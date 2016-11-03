import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    
    @IBOutlet weak var inputTitleTF: UITextField!
    @IBOutlet weak var inputDescTF: UITextField!
    let noteEntity = "Note"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Note"
        
    }

    @IBAction func addNote(_ sender: UIButton) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        let noteManagedContext = NSEntityDescription.insertNewObject(forEntityName: noteEntity, into: managedContext)
        
        if let title = inputTitleTF.text {
            noteManagedContext.setValue(title, forKey: "title")
        }
        
        if let subTitle = inputDescTF.text {
            noteManagedContext.setValue(subTitle, forKey: "subTitle")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Error While Saving Data: \(error.userInfo)")
        }
        
        navigationController?.popViewController(animated: true)
    }
}
