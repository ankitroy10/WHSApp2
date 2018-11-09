//
//  AdminViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 10/18/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

var tutorList = [String]()
var tutorIndex = 0
var iteration = 0

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    let ref = Database.database().reference()
    var handle = DatabaseHandle()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        iteration = iteration + 1
        
        if (iteration < 2) {
            handle = ref.child("Tutors").child("Names of Tutors").observe(.childAdded) { (snapshot) in
                //print("here")
                let myPost = snapshot.value as? String
                if let frThePost = myPost {
                    tutorList.append(frThePost)
                    self.table.reloadData()
                    
                }
                
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell")
        cell?.textLabel?.text = tutorList[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tutorIndex = indexPath.row
        performSegue(withIdentifier: "goToTutors", sender: self)
    }
    

}
