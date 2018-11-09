//
//  TutorViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 10/24/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var namer = String()
class TutorViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var noOfStudents: UILabel!
    @IBOutlet weak var tutoredNum: UILabel!
    @IBOutlet weak var tutoredMin: UILabel!
    
    let tutorUser = tutorList[tutorIndex]
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text! = tutorUser
        namer = tutorUser
        
        handle = ref.child("Tutors").child(tutorUser).child("Name").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.nameLabel.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(tutorUser).child("Current Students").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.noOfStudents.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(tutorUser).child("No of Tutored").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.tutoredNum.text = snapshot.value as? String
        })
        
        handle = ref.child("Tutors").child(tutorUser).child("Total Minutes").observe(.childAdded, with: { (snapshot) in
            //print("here")
            self.tutoredMin.text = snapshot.value as? String
        })
    }
    
    @IBAction func view(_ sender: Any) {
        performSegue(withIdentifier: "cmon", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
