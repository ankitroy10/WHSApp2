//
//  WelcomeViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 8/26/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var username = String()

class WelcomeViewController: UIViewController {
    @IBOutlet weak var nameOfTheTutor: UILabel!
    @IBOutlet weak var minutesTutored: UILabel!
    
    var totalHours = String()
    var itHappened = false
    var handle = DatabaseHandle()
    var ref = Database.database().reference()
    
    var goAhead = false
    var nameString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goAhead = false
        if (itHappened == false) {
            nameOfTheTutor.text! = nameString
            username = nameString
        }
        
        handle = ref.child("Tutors").child(username).child("Total Minutes").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.minutesTutored.text = snapshot.value as? String
        })
        
        
    }
    
    @IBAction func signedUpPressed(_ sender: Any) {
        goAhead = true
        performSegue(withIdentifier: "goToSignedUp", sender: self)
    }
    
    @IBAction func claimedPressed(_ sender: Any) {
        performSegue(withIdentifier: "giveMeTheJuice", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (goAhead) {
            let studentsViewController = segue.destination as? StudentsViewController
            studentsViewController?.tutorName = nameString
        }
        else {
            let claimedViewController = segue.destination as? ClaimedViewController
            claimedViewController?.tutor = nameString
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
