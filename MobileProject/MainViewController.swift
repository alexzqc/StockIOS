//
//  MainViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-26.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITextFieldDelegate {

    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
    if self.view.frame.origin.y == 0 {
    self.view.frame.origin.y -= keyboardSize.height
    }
    }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
    self.view.frame.origin.y = 0
    }
    }
        
  @IBOutlet weak var stockQuantity: UITextField!
  @IBAction func showInfo(_ sender: Any) {
    self.performSegue(withIdentifier: "viewPersonal", sender: self)
  }
  @IBOutlet weak var stockSymbolLabel: UILabel!
    @IBOutlet weak var stockOpenLabel: UILabel!
  @IBOutlet weak var errMsg: UILabel!
  @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var stockHighLabel: UILabel!
    @IBOutlet weak var stockLowLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockVolumeLabel: UILabel!
    @IBOutlet weak var stockLastTradingDayLabel: UILabel!
    @IBOutlet weak var stockPreviousCloseLabel: UILabel!
    @IBOutlet weak var stockChangeLabel: UILabel!
    @IBOutlet weak var stockChangePercentLabel: UILabel!
    @IBAction func stockSearchTapped(_ sender: Any) {
        getStockQuote()
        dismissKeyboard()
    }
    @IBAction func stockBuyTapped(_ sender: Any) {
        buyNow()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    getStockQuote()
    self.view.endEditing(true)
    return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetLabels()
        self.stockTextField.delegate = self
      
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
  func buyNow(){
    let textFromStockQuantity = stockQuantity.text
    
    var quantity = Int(textFromStockQuantity!)
    
    if quantity == nil{
      errMsg.text = "Please enter a valid intager number"
    }else{
    
    }
  }
  
  func getStockQuote() {
  let session = URLSession.shared
  let quoteURL = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(stockTextField.text ?? "")&apikey=NGBZ2Y86AE32ZLWH")!
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
  if let symbol = quoteDictionary.value(forKey: "01. symbol") {
  self.stockSymbolLabel.text = symbol as? String
  }
  if let open = quoteDictionary.value(forKey: "02. open") {
  self.stockOpenLabel.text = open as? String
  }
  if let high = quoteDictionary.value(forKey: "03. high") {
  self.stockHighLabel.text = high as? String
  }
  if let low = quoteDictionary.value(forKey: "04. low") {
  self.stockLowLabel.text = low as? String
  }
  if let price = quoteDictionary.value(forKey: "05. price") {
  self.stockPriceLabel.text = price as? String
  }
  if let volume = quoteDictionary.value(forKey: "06. volume") {
  self.stockVolumeLabel.text = volume as? String
  }
  if let latest = quoteDictionary.value(forKey: "07. latest trading day") {
  self.stockLastTradingDayLabel.text = latest as? String
  }
  if let previous = quoteDictionary.value(forKey: "08. previous close") {
  self.stockPreviousCloseLabel.text = previous as? String
  }
  if let change = quoteDictionary.value(forKey: "09. change") {
  self.stockChangeLabel.text = change as? String
  }
  if let changePercent = quoteDictionary.value(forKey: "10. change percent") {
  self.stockChangePercentLabel.text = changePercent as? String
  }
  }
  } else {
  print("Error: unable to find quote")
  DispatchQueue.main.async {
  self.resetLabels()
  }
  }
  } else {
  print("Error: unable to convert json data")
  DispatchQueue.main.async {
  self.resetLabels()
  }
  }
  } else {
  print("Error: did not receive data")
  DispatchQueue.main.async {
  self.resetLabels()
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
    func resetLabels() {
    stockSymbolLabel.text = "";
    stockOpenLabel.text = "";
    stockHighLabel.text = "";
    stockLowLabel.text = "";
    stockPriceLabel.text = "";
    stockVolumeLabel.text = "";
    stockLastTradingDayLabel.text = "";
    stockPreviousCloseLabel.text = "";
    stockChangeLabel.text = "";
    stockChangePercentLabel.text = "";
    }
}
