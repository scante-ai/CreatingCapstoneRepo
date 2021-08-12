//
//  SingleViewVC.swift
//  NoteAppCoreData
//
//  Created by Lin Zhang on 8/10/21.
//

import UIKit
import CoreData



class SingleViewVC: UIViewController {
    
    @IBOutlet weak var Description1: UILabel!
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Date1: UILabel!
    @IBOutlet weak var Wavelength: UILabel!
    var selectedJournal : Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Title1.text = selectedJournal.title
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        Date1.text = formatter.string(from: selectedJournal.deletedDate!)

        Wavelength.text = selectedJournal.wavelength
        Description1.text = selectedJournal.desc
        
    }

}
