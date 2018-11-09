//
//  ClaimedInfoViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 8/31/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//
/*
 TO DO:
 Fix the reason why 'theIndex' is not refreshing in Claimed Students Table[DONE]
 Finish fixing the minutes logging[DONE]
 Add constraints and fix WHS picture on front page
 
 Email back Mr. Shepherd
 Look into launching an app onto the App Store
*/

import UIKit
import Firebase

class ClaimedInfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    var justDoIt = false;
    var beta = Int()
    var total = Int()
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    var number = Int()
    var current = Int()
    
    @IBAction func removePressed(_ sender: Any) {
        callAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childName = studentData[theIndex]
        //print(username)
        nameLabel.text! = studentData[theIndex]
        
        
        handle = ref.child("Tutors").child(username).child("Claimed Students").child(childName).child("Email").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.email.text = snapshot.value as? String
        })
         
        
        handle = ref.child("Tutors").child(username).child("Claimed Students").child(childName).child("Subject").observe(.childAdded, with: { (snapshot) in
            print(theIndex)
            self.subject.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(username).child("Claimed Students").child(studentData[theIndex]).child("Information").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.information.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(username).child("Claimed Students").child(studentData[theIndex]).child("Duration").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.duration.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(username).child("Claimed Students").child(studentData[theIndex]).child("Duration").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.beta = Int((snapshot.value as? String)!)!
            
            //print(self.beta)
        })
        
        handle = ref.child("Tutors").child(username).child("Total Minutes").observe(.childAdded, with: { (snapshot) in
            self.total = Int((snapshot.value as? String)!)!
            //print(self.total)
        })
        
        handle = ref.child("Tutors").child(username).child("No of Tutored").observe(.childAdded, with: { (snapshot) in
            self.number = Int((snapshot.value as? String)!)!
            //print(self.total)
        })
        
        handle = ref.child("Tutors").child(username).child("Current Students").observe(.childAdded, with: { (snapshot) in
            self.current = Int((snapshot.value as? String)!)!
            //print(self.total)
        })
 
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func callAlert() {
        let alert = UIAlertController(title: "Do You Want To Remove?", message: "Are you sure you want to remove this student? Please continue only if you have finished tutoring this student.", preferredStyle: UIAlertController.Style.alert)
     
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.ref.child("Tutors").child(username).child("Claimed Students").child("Claimed Students Name").child(studentData[theIndex]).removeValue()
            self.ref.child("Tutors").child(username).child("Claimed Students").child(studentData[theIndex]).removeValue()
            
            self.justDoIt = true
            self.performSegue(withIdentifier: "finishedRemoving", sender: self)
    
        }))
     
     
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
     
        self.present(alert, animated: true, completion: nil)
     }
    
    /*
    // MARK: - Navigation
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (justDoIt) {
            let welcomeView = segue.destination as! WelcomeViewController
            welcomeView.nameString = username
            
            total = total + beta
            //print(total)
            self.ref.child("Tutors").child(username).child("Total Minutes").removeValue()
            ref.child("Tutors").child(username).child("Total Minutes").childByAutoId().setValue(String(total))
            self.ref.child("Tutors").child(username).child("No of Tutored").removeValue()
            ref.child("Tutors").child(username).child("No of Tutored").childByAutoId().setValue(String(number + 1))
            self.ref.child("Tutors").child(username).child("Current Students").removeValue()
            ref.child("Tutors").child(username).child("Current Students").childByAutoId().setValue(String(current - 1))
            ref.child("Tutors").child(username).child("History").child(studentData[theIndex]).setValue(beta)
        }
    }
 

}
