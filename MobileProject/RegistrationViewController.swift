//
//  RegistrationViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-26.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

  
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBAction func registerButtonTapped(_ sender: UIButton) {
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if let err = error {
          // there was an error, print it
          print(err)
        } else {
          let balance = 10000
          let stockName = "Default"
          let stockQuantity = 0.0
          let stock: [String: Any] = ["id": 0,
                                      "stockName": stockName,
                                      "stockQuantity": stockQuantity]
          
          let stocks: [String: Any] = ["stock": stock]
          
          let user:[String: Any] = ["name": email,
                                    "balance": balance,
                                    "stocks": stocks]
          var ref: DatabaseReference!
          ref = Database.database().reference()
          ref.child("Users").childByAutoId().setValue(user)
          
          // successfully created user
          print("successfully created user " + email)
          self.performSegue(withIdentifier: "showStock", sender: self)
        }
      }
    }
  }
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
