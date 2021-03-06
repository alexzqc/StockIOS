//
//  LoginViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-26.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextFiled: UITextField!
  @IBOutlet weak var passwordTextFiled: UITextField!
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    if let e = emailTextFiled.text, let p = passwordTextFiled.text{
    Auth.auth().signIn(withEmail: e, password: p)
    {
      (user,error) in
      if let err = error{
        print("Opps")
        print(err)
      }else{
        print("Logged in as")
        print(user!.user.email)
        self.performSegue(withIdentifier: "showStockFromLogin", sender: self)
      }
    }
    }}
  
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

