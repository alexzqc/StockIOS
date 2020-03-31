//
//  PerfoamanceViewController.swift
//  MobileProject
//
//  Created by Ziqi  Chen on 2020-03-30.
//  Copyright © 2020 Team Ziqi Chen. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints
import Firebase


class PerfoamanceViewController: UIViewController,ChartViewDelegate {
  
var userID = Auth.auth().currentUser!.uid
  
  var plotData:[Double]? = []
  
  var yValues: [ChartDataEntry] = [
    ChartDataEntry(x: 0.0, y: 10000)
  ]
  
  lazy var lineChartView: LineChartView = {
    let chartView = LineChartView()
    chartView.backgroundColor = .systemBlue
    return chartView
  }()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.addSubview(lineChartView)
      lineChartView.centerInSuperview()
      lineChartView.width(to: view)
      lineChartView.heightToWidth(of: view)
        
      getArray()
      getData()
        // Do any additional setup after loading the view.
    }
    
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    print(entry)
  }
  
  func getArray(){
   
  }
  
  func getData(){
    let messagesDB = Database.database().reference().child("Users")
       messagesDB.child(userID).observeSingleEvent(of: .value) { (snapshot) in
         if let dictionary = snapshot.value as? [String:AnyObject]{
           self.plotData = dictionary["balanceHistory"] as? [Double]
          print(self.plotData!)
          for i in 1..<self.plotData!.count {
               let dataEntry = ChartDataEntry(x: Double(i), y: self.plotData![i])
            self.yValues.append(dataEntry)
             }
          let set1 = LineChartDataSet(entries: self.yValues, label: "Balance")
             let data = LineChartData(dataSet: set1)
          self.lineChartView.data = data
         }
        
     }
   
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

