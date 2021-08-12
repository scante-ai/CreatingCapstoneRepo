//
//  ZeroFTVC.swift
//  NoteAppCoreData
//
//  Created by mitul marsonia on 12/08/21.
//

import UIKit

class TwoFTVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Added navigation button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(backToInitial(sender:)))
    }
    @objc func backToInitial(sender: AnyObject) {
        // Move to Home screen
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
