//
//  AddInfoViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 9/2/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

class AddInfoViewController: UIViewController {
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var place: UITextField!
    var setUpName = false
    var current = Int()
    
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = ref.child("Tutors").child(username).child("Current Students").observe(.childAdded, with: { (snapshot) in
            self.current = Int((snapshot.value as? String)!)!
            //print(self.total)
        })
        
    }

    @IBAction func submitPressed(_ sender: Any) {
        if (time.text!.isEmpty || place.text!.isEmpty) {
            callEmptyAlert(title: "Error", message: "Please fill out all the forms")
        }
        
        else {
            callAlert()
        }
    }
    
    func callEmptyAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func callAlert() {
        let alert = UIAlertController(title: "Do You Want To Claim?", message: "Are you sure you want to claim this student? Please continue only if you have reached out to this student as continuing will remove his/her information from the database.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.ref.child("Tutors").child(username).child("Claimed Students").child("Claimed Students Name").child(nameOfStudent).setValue(nameOfStudent)
            self.ref.child("Tutors").child(username).child("Claimed Students").child(nameOfStudent).child("Email").childByAutoId().setValue(email)
            self.ref.child("Tutors").child(username).child("Claimed Students").child(nameOfStudent).child("Information").childByAutoId().setValue(info)
            self.ref.child("Tutors").child(username).child("Claimed Students").child(nameOfStudent).child("Subject").childByAutoId().setValue(subject)
            self.ref.child("Tutors").child(username).child("Claimed Students").child(nameOfStudent).child("Location").childByAutoId().setValue(self.place.text!)
            self.ref.child("Tutors").child(username).child("Claimed Students").child(nameOfStudent).child("Duration").childByAutoId().setValue(self.time.text!)
            self.ref.child("Tutors").child(username).child("Current Students").removeValue()
            self.ref.child("Tutors").child(username).child("Current Students").childByAutoId().setValue(String(self.current + 1))
            
            self.ref.child("Students").child(postData[myIndex]).removeValue()
            self.ref.child("Additional Information").child(postData[myIndex]).removeValue()
            self.ref.child("Names").child(postData[myIndex]).removeValue()
            self.setUpName = true
            
            self.performSegue(withIdentifier: "finishedClaiming", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "noClaim", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (setUpName) {
            let welcomeViewController = segue.destination as? WelcomeViewController
            welcomeViewController?.nameString = username
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        time.resignFirstResponder()
        place.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    

}
