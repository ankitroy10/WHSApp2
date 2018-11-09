//
//  StudentHistoryViewController.swift
//  WHSApp2
//
//  Created by Ankit Roy on 10/25/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newIndex = 0
    var historyList = [String]()
    var iterate = 0
    
    var handle = DatabaseHandle()
    let ref = Database.database().reference()
    
    
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTable.delegate = self
        historyTable.dataSource = self
        
        iterate = iterate + 1
        
        
        if (iterate < 2) {
            handle = ref.child("Tutors").child(namer).child("History").observe(.childAdded) { (snapshot) in
                //print("here")
                let lastPost = snapshot.value as? String
                if let histPost = lastPost {
                    self.historyList.append(histPost)
                    print(self.historyList[0])
                    self.historyTable.reloadData()
                    
                }
                
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histCell")
        cell?.textLabel?.text = historyList[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        newIndex = indexPath.row
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
