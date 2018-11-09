//
//  StudentsViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 3/28/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var postData = [String]()
var myIndex = 0
var tutor = String()
var work = 0

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tutorName = String()
    var hasHappened = false
    
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        work = work + 1
        tableView.delegate = self
        tableView.dataSource = self
        
        tutor = tutorName
        
        if (work < 2) {
            handle = ref.child("Names").observe(.childAdded) { (snapshot) in
                print("here")
                let post = snapshot.value as? String
                if let actualPost = post {
                    postData.append(actualPost)
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
        
        hasHappened = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "newSegue", sender: self)
    }
    
    
}

