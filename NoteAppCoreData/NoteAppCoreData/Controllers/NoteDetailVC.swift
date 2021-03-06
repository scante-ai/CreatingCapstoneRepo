import UIKit
import CoreData
//entering note info
class NoteDetailVC: UIViewController
{//Title text Field
	@IBOutlet weak var titleTF: UITextField!
    //Description Text Field
	@IBOutlet weak var descTV: UITextView!
	
	var selectedNote: Note? = nil //class?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		if(selectedNote != nil)
		{//displays title and description
			titleTF.text = selectedNote?.title
			descTV.text = selectedNote?.desc
		}
	}

    
	@IBAction func saveAction(_ sender: Any)
	{
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
		
        
        //if selected note is empty; create a new note; newNote doesnt need segue?
        if(selectedNote == nil)
		{//calling Note class in data model
			let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
			
            //creating new note ?
            let newNote = Note(entity: entity!, insertInto: context)
			newNote.id = noteList.count as NSNumber
			newNote.title = titleTF.text
			newNote.desc = descTV.text
            if (newNote.title != nil && newNote.desc != nil) {
                
            
			do
			{//saving to noteList array
				try context.save()
				noteList.append(newNote)
				navigationController?.popViewController(animated: true)
			}
			catch
			{
				print("context save error")
            }
                
            }
		}
		
        //if selected note is not empty
        else //edit
		{ //fetch note
			let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
			do {
				let results:NSArray = try context.fetch(request) as NSArray
				for result in results
				{
					let note = result as! Note
					if(note == selectedNote)
					{//display note info?
						note.title = titleTF.text
						note.desc = descTV.text
						try context.save()
						navigationController?.popViewController(animated: true)
					}
				}
			}
			catch
			{
				print("Fetch Failed")
			}
		}
	}
	//Deleting Note
	@IBAction func DeleteNote(_ sender: Any)
	{//core data persistent container
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
		//fetching info from Note entity
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
		do {
			let results:NSArray = try context.fetch(request) as NSArray
			for result in results
			{//if note is slected, delete
				let note = result as! Note
				if(note == selectedNote)
				{
					note.deletedDate = Date()
					try context.save()
					navigationController?.popViewController(animated: true) //pop up display
				}
			}
		}
		catch
		{
			print("Fetch Failed")
		}
	}
	
}

