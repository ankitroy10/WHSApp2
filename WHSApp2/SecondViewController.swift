//
//  SecondViewController.swift
//  WHS Tutoring App
//
//  Created by Ankit Roy on 3/5/18.
//  Copyright © 2018 Ankit Roy. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var studentIDField: UITextField!
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var teacherField: UITextField!
    
    var execute = true
    var ref = Database.database().reference()
    var test = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        studentIDField.delegate = self
        subjectField.delegate = self
        teacherField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool {
        if withIdentifier == "mySegue" {
            if (nameField.text!.isEmpty || studentIDField.text!.isEmpty || subjectField.text!.isEmpty || teacherField.text!.isEmpty) {
                print("Please fill out all forms.")
                callAlert(title: "Error", message: "Please fill out every form.")
                
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
    
    @IBAction func pressedContinue(_ sender: Any) {
        performSegue(withIdentifier: "mySegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let thirdController = segue.destination as! ThirdViewController
        
        thirdController.nameString = nameField.text!
        thirdController.studentIDString = studentIDField.text!
        thirdController.subjectString = subjectField.text!
        thirdController.teacherString = teacherField.text!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        studentIDField.resignFirstResponder()
        nameField.resignFirstResponder()
        subjectField.resignFirstResponder()
        teacherField.resignFirstResponder()
    }
    
}

extension ViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
}

