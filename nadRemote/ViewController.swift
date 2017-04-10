//
//  ViewController.swift
//  nadRemote
//
//  Created by Anders Michaelsen on 03/04/2017.
//  Copyright © 2017 Anders Michaelsen. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    var api : LircAPI = LircAPI()
    var volume : Float = 0.0
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func onButtonPress(_ sender: Any) {
        let btn = sender as! UIButton
        if let code = btn.accessibilityLabel {
            sendCode(code: code)
        }
        else {
            print("Missing label on button")
        }
    }
    
    func sendCode(code : String) {
        spinner.startAnimating()
        api.sendCode(code) { result, error in
            print("sendCode Completed!")
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
            guard error == nil else {
                print("Error calling API")
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

