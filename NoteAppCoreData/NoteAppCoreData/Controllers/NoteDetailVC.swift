import UIKit
import CoreData
//entering note info
class NoteDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Make variable global
    var waves:String = ""

//Title text Field
	@IBOutlet weak var titleTF: UITextField!
    //Description Text Field
	@IBOutlet weak var descTV: UITextView!
	
	var selectedNote: Note? = nil //class?
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    // Input the data into the array
    var pickerData = [["0 ft", "15 ft", "30 ft", "50 ft"]]
    
	override func viewDidLoad(){
		super.viewDidLoad()
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
    
        
		if(selectedNote != nil)
		{//displays title and description
			titleTF.text = selectedNote?.title
			descTV.text = selectedNote?.desc
		}
	}

    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Make var global using self
        self.waves = pickerData[component][row]
        print(waves)
        // This method is triggered whenever the user makes a change to the picker selection
        // The parameter named row and component represents what was selected...
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
                newNote.desc = descTV.text //mandatory
                newNote.deletedDate = Date()
                // use global variable here (self.waves also works ???)
                newNote.wavelength = waves //mandatory
                
//                if (newNote.wavelength != "" || newNote.desc != "") {
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
//        @IBAction func DeleteNote(_ sender: Any)
//        {//core data persistent container
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//            //fetching info from Note entity
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//            do {
//                let results:NSArray = try context.fetch(request) as NSArray
//                for result in results
//                {//if note is slected, delete
//                    let note = result as! Note
//                    if(note == selectedNote)
//                    {
//                        note.deletedDate = Date()
//                        try context.save()
//                        navigationController?.popViewController(animated: true) //pop up display
//                    }
//                }
//            }
//            catch
//            {
//                print("Fetch Failed")
//            }
//        }
//
    }
