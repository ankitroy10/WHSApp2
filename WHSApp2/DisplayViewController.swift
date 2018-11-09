//
//  DisplayViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 3/28/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var nameOfStudent = String()
var email = String()
var info = String()
var subject = String()

class DisplayViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentIDLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var addInfoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var claimStudent: UIButton!

    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    var doIt = false
    
    @IBAction func claimPressed(_ sender: Any) {
        performSegue(withIdentifier: "addInfo", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = postData[myIndex]
        nameOfStudent = postData[myIndex]
        
        handle = ref.child("Students").child(postData[myIndex]).child("StudentID").observe(.childAdded, with: { (snapshot) in
            //print(myIndex)
            self.studentIDLabel.text = snapshot.value as? String
        })
        
        handle = ref.child("Students").child(postData[myIndex]).child("Email").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.emailLabel.text = snapshot.value as? String
            email = (snapshot.value as? String)!
        })
        
        handle = ref.child("Students").child(postData[myIndex]).child("Subject").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.subjectLabel.text = snapshot.value as? String
            subject = (snapshot.value as? String)!
        })
        
        handle = ref.child("Students").child(postData[myIndex]).child("Teacher").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.teacherLabel.text = snapshot.value as? String
        })
        
        handle = ref.child("Additional Information").child(postData[myIndex]).observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.addInfoLabel.text = snapshot.value as? String
            info = (snapshot.value as? String)!
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /* func callAlert() {
        let alert = UIAlertController(title: "Do You Want To Claim?", message: "Are you sure you want to claim this student? Please continue only if you have reached out to this student as continuing will remove his/her information from the database.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.ref.child("Students").child(postData[myIndex]).removeValue()
            self.ref.child("Additional Information").child(postData[myIndex]).removeValue()
            self.ref.child("Names").child(postData[myIndex]).removeValue()
        }))
 
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    } */
    
    

}
