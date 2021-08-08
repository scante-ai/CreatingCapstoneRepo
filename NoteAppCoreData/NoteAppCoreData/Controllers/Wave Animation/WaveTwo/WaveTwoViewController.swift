//
//  WaveTwoViewController.swift
//  NoteAppCoreData
//
//  Created by Ada on 8/7/21.
//

import UIKit
import SwiftUI

class WaveTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = UIHostingController(rootView: Wave2UIView())
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalToConstant: 0.3)
//            ,
//            controller.view.heightAnchor.constraint(equalToConstant: 44),
//            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
        
    }
        
//        NSLayoutConstraint.activate([
//            controller.view.widthAnchor.constraint(equalToConstant: 200),
//            controller.view.heightAnchor.constraint(equalToConstant: 44),
//            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//
//        ])

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
