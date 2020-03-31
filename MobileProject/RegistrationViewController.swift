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
  
  @IBOutlet weak var errorWindow: UILabel!
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var confirmPassword: UITextField!
  
  @IBAction func registerButtonTapped(_ sender: UIButton) {
    
    if passwordTextField.text == confirmPassword.text{
    if let email = emailTextField.text, let password = passwordTextField.text {
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      if let err = error {
        // there was an error, print it
        print(err)
      } else {
        let uid = user!.user.uid
        let balance = 10000
        let balanceHistory:[Double] = [10000]
        let user:[String: Any] = ["name": email,
                                  "balance": balance,
                                  "balanceHistory": balanceHistory]
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userReferencce = ref.child("Users").child(uid)
        userReferencce.updateChildValues(user, withCompletionBlock: {(error,ref) in
          if(error != nil){
            print(error!)
            return
          }
          print("successfully created user " + email)
          self.performSegue(withIdentifier: "showStock", sender: self)
        })
      }}}}else{
      self.errorWindow.text = "Password does not match with password confirmed"
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
