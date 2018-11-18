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
        
        // Modificando el tamaño de text field
//        var frameRect: CGRect = textInputName.frame;
//        frameRect.size.height = 50;
//        textInputName.frame = frameRect;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClick(_ sender:Any) {
        var urlComponents = URLComponents(string: "https://avires.net/suma/")!
        print(textInput1.text!)
        urlComponents.queryItems = [
            URLQueryItem(name: "n1", value: textInput1.text!),
            URLQueryItem(name: "n2", value: textInput2.text!)
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
            let responseObj = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            print(responseObj!)
            self.showMessage("Hello World!", message: responseObj?["mensaje"] as? String ?? "Message")
        }
        task.resume()
    }
    
    func showMessage(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
}

