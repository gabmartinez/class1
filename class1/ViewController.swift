//
//  ViewController.swift
//  class1
//
//  Created by Gabriel Martinez Guerrero on 11/17/18.
//  Copyright © 2018 Gabriel Martinez Guerrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textInput1: UITextField!;
    @IBOutlet weak var textInput2: UITextField!;
    
    @IBOutlet weak var numberLabel: UILabel!;
    @IBOutlet weak var letterLabel: UILabel!;
    @IBOutlet weak var messageLabel: UILabel!;
    
    @IBAction func onClick(_ sender:Any) {
        var urlComponents = URLComponents(string: "https://avires.net/suma/")!
        urlComponents.queryItems = [
            URLQueryItem(name: "n1", value: textInput1.text!),
            URLQueryItem(name: "n2", value: textInput2.text!)
        ];
        
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
                    DispatchQueue.main.async {
                        self.numberLabel.text = String(responseObj["data"]! as! Int);
                        self.letterLabel.text = responseObj["enLetras"]! as? String ?? "letras";
                        self.messageLabel.text = responseObj["mensaje"]! as? String ?? "mensaje";
                    }
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }

}

