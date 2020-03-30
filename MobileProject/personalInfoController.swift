//
//  personalInfoController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-29.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Firebase

class personalInfoController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
  var userID = Auth.auth().currentUser!.uid
  var postdata = [String]()
  var stockName = ""
  var quantityTotal = 0
  
  
  @IBOutlet weak var stockTableView: UITableView!
  
  @IBOutlet weak var balanceDisplay: UILabel!
  
  @IBOutlet weak var nameDisplay: UILabel!
  override func viewDidLoad() {
      super.viewDidLoad()
      getInfo()
      stockTableView.delegate = self
      stockTableView.dataSource = self

    let ref = Database.database().reference().child("Users").child(self.userID).child("stocks")
        // Do any additional setup after loading the view.
    
    ref.observeSingleEvent(of: .value) { (snapshot) in
     for child in snapshot.children {
     let snap = child as! DataSnapshot
     let post = snap.key as? String
      if let actualPost = post {
        self.postdata.append(actualPost)
         self.stockTableView.reloadData()
      }
      }
      
    }
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let stockDetailsController = segue.destination as? StockDetailsViewController, let index = stockTableView.indexPathForSelectedRow?.row
    {
      print(postdata)
      print(index)
      print(postdata[index])
      stockDetailsController.symbol = postdata[index]
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return postdata.count
   }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockView")
    let a = postdata[indexPath.row]
    cell?.textLabel?.text = postdata[indexPath.row]
    stockName = a
    return cell!
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
       }
    }
    
}
