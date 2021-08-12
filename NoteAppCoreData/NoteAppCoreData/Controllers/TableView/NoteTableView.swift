import UIKit
import CoreData

//seeing list of notes
var noteList = [Note]()

class NoteTableView: UITableViewController
{
	var firstLoad = true
	//add all notes to note list
	func nonDeletedNotes() -> [Note]
	{
		var noDeleteNoteList = [Note]()
		for note in noteList
		{
			if(note.deletedDate != nil)
			{
				noDeleteNoteList.append(note)
			}
		}
		return noDeleteNoteList
	}
	
	override func viewDidLoad()
	{//load firstload that has array of notes
        //Just empty array when back to again array should be empty.
        noteList = []
		if(firstLoad)
		{
			firstLoad = false //? set it false
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
			let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
			do {//fetch note info
				let results:NSArray = try context.fetch(request) as NSArray
				for result in results
				{//append fetched note to results
//                    print(result)
					let note = result as! Note
					noteList.append(note)
				}
//                print(noteList)
			}
			catch
			{
				print("Fetch Failed")
			}
		}
	}
	
	
    //declare cells in TableViews
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{ //calling noteCellID identifier, NoteCell class has labels with title and desc
		let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
		
		let thisNote: Note!
		thisNote = nonDeletedNotes()[indexPath.row]
		
		noteCell.titleLabel.text = thisNote.title
//		noteCell.descLabel.text = thisNote.desc
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        self.subtitleLabel.text = "Edited on \(formatter.string(from: note.lastEdited))"
        
        //crash if deleted date doesn't exist
        noteCell.dateLabel.text = formatter.string(from: thisNote.deletedDate!)
		
		return noteCell
	}
	
	//number of rows generated !
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return nonDeletedNotes().count
	}
	//loading view
	override func viewDidAppear(_ animated: Bool)
	{
		tableView.reloadData()
	}
    
    
    
//    
//    //replace variable "selectedNote" in single view VC
//    
//	//Segue into single view page
//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//	{//arrow going to NoteDetail
//		self.performSegue(withIdentifier: "SummarySegue", sender: self)
//	}
//	//prepare segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
        //Pass data to view details screen.
		if(segue.identifier == "SummarySegue")
		{
			let indexPath = tableView.indexPathForSelectedRow!
			
			let journalEntry = segue.destination as? SingleViewVC
			//select Note
			let selectedJournal : Note!
			selectedJournal = nonDeletedNotes()[indexPath.row]
			journalEntry!.selectedJournal = selectedJournal
			
			tableView.deselectRow(at: indexPath, animated: true)
		}
	}
	
	
}
