//
//  ClaimedViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 8/31/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var studentData = [String]()
var theIndex = 0
var please = 0

class ClaimedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hasOccured = false
    var tutor = String()
    
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        please = please + 1
        
        tableView.delegate = self
        tableView.dataSource = self

        if (please < 2) {
            handle = ref.child("Tutors").child(username).child("Claimed Students").child("Claimed Students Name").observe(.childAdded) { (snapshot) in
                //print("here")
                let myPost = snapshot.value as? String
                if let myActualPost = myPost {
                    studentData.append(myActualPost)
                    self.tableView.reloadData()
                    
                }
                

            }
            
        }
        hasOccured = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = studentData[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        theIndex = indexPath.row
        performSegue(withIdentifier: "viewInfo", sender: self)
    }

    

}
