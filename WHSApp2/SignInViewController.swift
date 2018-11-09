//
//  SignInViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 4/1/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var ref = Database.database().reference()
    var handle = DatabaseHandle()
    var carryOut = false
    
    var idName = String()
    
    var doIt = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        let execute:Bool = username.text!.isEmpty && password.text!.isEmpty
        
        if (!execute) {
            Auth.auth().signIn(withEmail: username.text!, password: password.text!, completion: { (user, error) in
                if user != nil {
                    if (self.username.text! == "whstutoringapp@gmail.com") {
                        self.performSegue(withIdentifier: "goToAdminView", sender: self)
                    }
                    self.doIt = true
                    self.idName = self.username.text!
                    self.carryOut = true
        
                    self.performSegue(withIdentifier: "goToWelcome", sender: self)
                }
                
                else {
                    self.callAlert(title: "Error", message: "Please provide a valid username and password")
                }
            })
        }
        
        else {
            callAlert(title: "Error", message: "Please enter a username and password.")
        }
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (carryOut) {
            let welcomeViewController = segue.destination as! WelcomeViewController
            idName = self.username.text!
            let endSentence = idName.index(of: "@") ?? idName.endIndex
            let firstSentence = idName[..<endSentence]
            
            idName = String(firstSentence)
            welcomeViewController.nameString = idName
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
}
