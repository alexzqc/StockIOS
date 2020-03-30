//
//  StockDetailsViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-30.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Firebase

class StockDetailsViewController: UIViewController {
  var symbol = ""
  var userID = Auth.auth().currentUser!.uid
  
  @IBOutlet weak var quantityIndicator: UILabel!
  @IBOutlet weak var stockName: UILabel!
  @IBOutlet weak var unitprice: UILabel!
  
  @IBOutlet weak var lowPrice: UILabel!
  @IBOutlet weak var hiPrice: UILabel!
  @IBOutlet weak var volumn: UILabel!
  @IBOutlet weak var latestTradingDay: UILabel!
  @IBOutlet weak var previousDat: UILabel!
  @IBOutlet weak var changeInPercent: UILabel!
  @IBOutlet weak var change: UILabel!
  override func viewDidLoad() {
        super.viewDidLoad()
        stockName.text = symbol
        // Do any additional setup after loading the view.
    getDetails()
    getStockQuote()
    }
    
  func getDetails(){
    let ref = Database.database().reference().child("Users").child(self.userID).child("stocks").child(symbol)
    
    ref.observeSingleEvent(of: .value) { (snapshot) in
      if let dictionary = snapshot.value as? [String:AnyObject]{
        let a = dictionary["stockQuantity"] as? Int
        self.quantityIndicator.text = String(a!)
      }
    }
  }

  func getStockQuote() {
  let session = URLSession.shared
    let quoteURL = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol )&apikey=NGBZ2Y86AE32ZLWH")!
  let dataTask = session.dataTask(with: quoteURL) {
  (data: Data?, response: URLResponse?, error: Error?) in
  if let error = error {
  print("Error:\n\(error)")
  } else {
  if let data = data {
  let dataString = String(data: data, encoding: String.Encoding.utf8)
  print("All the quote data:\n\(dataString!)")
  if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
  if let quoteDictionary = jsonObj.value(forKey: "Global Quote") as? NSDictionary {
  DispatchQueue.main.async {
  if let high = quoteDictionary.value(forKey: "03. high") {
    self.hiPrice.text = high as? String
  }
  if let low = quoteDictionary.value(forKey: "04. low") {
    self.lowPrice.text = low as? String
  }
  if let price = quoteDictionary.value(forKey: "05. price") {
    self.unitprice.text = price as? String
  }
    
  if let volume1 = quoteDictionary.value(forKey: "06. volume") {
    self.volumn.text = volume1 as? String
  }
  if let latest = quoteDictionary.value(forKey: "07. latest trading day") {
    self.latestTradingDay.text = latest as? String
  }
  if let previous = quoteDictionary.value(forKey: "08. previous close") {
    self.previousDat.text = previous as? String
  }
  if let change1 = quoteDictionary.value(forKey: "09. change") {
    self .change.text = change1 as? String
  }
  if let changePercent = quoteDictionary.value(forKey: "10. change percent") {
    self.changeInPercent.text = changePercent as? String
  }
  }
  } else {
  print("Error: unable to find quote")
  DispatchQueue.main.async {
  }
  }
  } else {
  print("Error: unable to convert json data")
  DispatchQueue.main.async {
  }
  }
  } else {
  print("Error: did not receive data")
  DispatchQueue.main.async {
  }
  }
  }
  }
  dataTask.resume()
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
