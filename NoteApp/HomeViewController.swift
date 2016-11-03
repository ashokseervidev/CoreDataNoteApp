import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notes = [Note]()
    let noteEntity = "Note"
    @IBOutlet weak var noteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notes"
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getNotes()
        
        noteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = note.title!
        cell.detailTextLabel!.text = note.subTitle!

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
         let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = notes[indexPath.row]
        if editingStyle == .delete {
            managedContext.delete(note)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
            
            do {
                notes = try managedContext.fetch(fetchRequest) as! [Note]
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }            
            noteTableView.reloadData()
        }
    }
    
    func getNotes() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
    
        do {
            notes = try managedContext.fetch(fetchRequest) as! [Note]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
    }

}

