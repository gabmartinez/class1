//
//  ViewController.swift
//  class1
//
//  Created by Gabriel Martinez Guerrero on 11/17/18.
//  Copyright © 2018 Gabriel Martinez Guerrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textInput1: UITextField!
    @IBOutlet weak var textInput2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClick(_ sender:Any) {
        let urlComponents = URLComponents(string: "https://avires.net/suma/?n1=\(textInput1.text!)&n2=\(textInput2.text!)")!
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: urlComponents.url!)) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    print ("server error")
                    return
            }
            
            do {
                if let responseObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                {
                    let msg: String = responseObj["enLetras"]! as? String ?? "N/A"
                    DispatchQueue.main.async {
                        self.showMessage("Hello World!", message: msg)
                    }
                } else {
                    print("Error en la serializacion")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func showMessage(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
}

