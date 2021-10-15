//
//  ViewController.swift
//  counselor_assistant
//
//  Created by Yi Xu on 9/20/21.
//


import UIKit
class ViewController: UIViewController{ //UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var previousVisitsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        let visit = currentUser.getVisit()
//        //print("CURRENT WATCHLIST AMOUNT: \(currentWatchlist?.getStockList().count)")
//
//        let currentStockList = currentWatchlist?.getStockList()
//        if currentStockList!.isEmpty{
//            print("STOCK LIST EMPTY")
//            return 1
//        }
//        else {
//            return currentStockList!.count
//        }
        let test = 0
        return test
    }
//    func tableView(_ tableView: UITableView,
//                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       // Reuse or create a cell of the appropriate type.
//        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell",
//                             for: indexPath) as! HomePageStockViewCell
//        let stockList = currentUser.getWatchList()!.getStockList()
//        let currentStock = stockList[indexPath.row]
//
//
//
//       // Fetch the data for the row.
//       // Configure the cell’s contents with data from the fetched object.
//        let lowercaseSymbol = currentStock.getSymbol()
//        let upperCase = lowercaseSymbol.uppercased()
//        cell.symbolLabel.text = upperCase
//        let change:Double = currentStock.getChange() * 100
//
//        let twoDecimalPoints: String = String (format: "%.2f", change)
//        var rv: String = ""
//        if change > 0{
//            rv = "+" + (twoDecimalPoints) + "%"
//        }
//        else{
//            rv = (twoDecimalPoints) + "%"
//        }
//        cell.changeLabel.text = rv
//        cell.priceLabel.text = String(format: "%.2f", currentStock.getPrice())
//        return cell
    
//    }

    
}

