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
			if(note.deletedDate == nil)
			{
				noDeleteNoteList.append(note)
			}
		}
		return noDeleteNoteList
	}
	
	override func viewDidLoad()
	{//load firstload that has array of notes
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
					let note = result as! Note
					noteList.append(note)
				}
			}
			catch
			{
				print("Fetch Failed")
			}
		}
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{ //calling noteCellID identifier, NoteCell class has labels with title and desc
		let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
		
		let thisNote: Note!
		thisNote = nonDeletedNotes()[indexPath.row]
		
		noteCell.titleLabel.text = thisNote.title
		noteCell.descLabel.text = thisNote.desc
		
		return noteCell
	}
	
	//number of rows generated
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return nonDeletedNotes().count
	}
	//loading view
	override func viewDidAppear(_ animated: Bool)
	{
		tableView.reloadData()
	}
	//editing note when selected
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{//arrow going to NoteDetail
		self.performSegue(withIdentifier: "editNote", sender: self)
	}
	//prepare segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if(segue.identifier == "editNote")
		{
			let indexPath = tableView.indexPathForSelectedRow!
			
			let noteDetail = segue.destination as? NoteDetailVC
			//select Note
			let selectedNote : Note!
			selectedNote = nonDeletedNotes()[indexPath.row]
			noteDetail!.selectedNote = selectedNote
			
			tableView.deselectRow(at: indexPath, animated: true)
		}
	}
	
	
}
