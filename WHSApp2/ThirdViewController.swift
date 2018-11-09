//
//  ThirdViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 3/18/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class ThirdViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var infoField: UITextField!
    
    var nameString = String()
    var studentIDString = String()
    var subjectString = String()
    var teacherString = String()
    var emailString = String()
    var infoString = String()
    var test = false
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        infoField.delegate = self
        
    }
    
    @IBAction func addStudent(_ sender: Any) {
        if (shouldPerformSegue(withIdentifier: "newSegue", sender: self) == true) {
            emailString = emailField.text!
            infoString = infoField.text!
        
            ref.child("Students").child(nameString).child("StudentID").childByAutoId().setValue(studentIDString)
            ref.child("Students").child(nameString).child("Subject").childByAutoId().setValue(subjectString)
            ref.child("Students").child(nameString).child("Teacher").childByAutoId().setValue(teacherString)
            ref.child("Additional Information").child(nameString).childByAutoId().setValue(infoString)
            ref.child("Students").child(nameString).child("Email").childByAutoId().setValue(emailString)
            
            //additonal setup
            ref.child("Names").child(nameString).setValue(nameString)
        }
        /*
        if (!emailString.isEmpty) {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            composeVC.setToRecipients([emailString])
            composeVC.setSubject("Thank you for signing up for a tutor!")
            composeVC.setMessageBody("Hey, <b>\(nameString)!</b> This is a conformation email that your information has been recieved. You will recieve another email regarding a tutor in the future.", isHTML: true)
            
        }
        */
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        performSegue(withIdentifier: "newSegue", sender: self)
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool {
        if withIdentifier == "newSegue" {
            if (emailField.text!.isEmpty || infoField.text!.isEmpty) {
                print("Please fill out all forms.")
                callAlert(title: "Error", message: "Please fill out every form.")
                
                return false
            }
            
            if (isValidEmail(testStr: emailField.text!) == false) {
                print("Invalid email address.")
                callAlert(title: "Error", message: "Please provide a valid email address")
                
                return false
            }
        }
        return true
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        infoField.resignFirstResponder()
    }
}


