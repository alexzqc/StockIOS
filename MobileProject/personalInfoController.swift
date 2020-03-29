//
//  personalInfoController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-29.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Firebase

class personalInfoController: UIViewController {
  
  @IBOutlet weak var balanceDisplay: UILabel!
  
  @IBOutlet weak var nameDisplay: UILabel!
  override func viewDidLoad() {
        super.viewDidLoad()
      getInfo()
        // Do any additional setup after loading the view.
    }
    func getInfo(){
       let uid = Auth.auth().currentUser?.uid
       let messagesDB = Database.database().reference().child("Users")
       messagesDB.child(uid!).observeSingleEvent(of: .value) { (snapshot) in
         if let dictionary = snapshot.value as? [String:AnyObject]{
           self.nameDisplay.text = dictionary["name"] as? String
           let balance = dictionary["balance"] as? Double
           let balanceString = String(format:"%.2f",balance!)
           self.balanceDisplay.text = balanceString
         }
         print(snapshot)
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
}
