//
//  StockDetailsViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-30.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit

class StockDetailsViewController: UIViewController {
        var symbol = ""
  @IBOutlet weak var stockName: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        stockName.text = symbol
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
