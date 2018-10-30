//
//  SecondViewController.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-07.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit

class JsonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var jsonTextBox: UITextView!
    @IBOutlet weak var jsonTextField: UITextField!
    
    @IBAction func fetchJsonButton(_ sender: UIButton) {
        let url = jsonTextField.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        jsonTextBox.text = "Fetched json will be displayed here"
    }
    
    
}





