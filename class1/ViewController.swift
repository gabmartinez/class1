//
//  ViewController.swift
//  class1
//
//  Created by Gabriel Martinez Guerrero on 11/17/18.
//  Copyright © 2018 Gabriel Martinez Guerrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textInputName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modificando el tamaño de text field
        var frameRect: CGRect = textInputName.frame;
        frameRect.size.height = 50;
        textInputName.frame = frameRect;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClick(_ sender:Any) {
        let value: String = textInputName.text!
        let alert = UIAlertController(title: "Hello World!", message: "Welcome \(value)", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
}

