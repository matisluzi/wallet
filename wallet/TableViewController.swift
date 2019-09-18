//
//  TableViewController.swift
//  wallet
//
//  Created by Matis Luzi on 9/18/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var dateArray: [String] = []
    var amountArray: [Double] = []
    var nameArray: [String] = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        dateArray = UserDefaults.standard.stringArray(forKey: "purchaseDates") ?? [String]()
        nameArray = UserDefaults.standard.stringArray(forKey: "purchaseNames") ?? [String]()
        amountArray = UserDefaults.standard.array(forKey: "purchaseAmounts") as? [Double] ?? [Double]()
        
        print(dateArray.count)
        print(nameArray.count)
        print(amountArray.count)
        self.tableView.rowHeight = 80;
    }
    
    

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserDefaults.standard.array(forKey: "purchaseAmounts")!.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell

        // Configure the cell...
        cell.showCellData(name: UserDefaults.standard.array(forKey: "purchaseNames")?[indexPath.row] as! String, date: UserDefaults.standard.array(forKey: "purchaseDates")?[indexPath.row] as! String, amount: UserDefaults.standard.array(forKey: "purchaseAmounts")?[indexPath.row] as! Double)
        print(UserDefaults.standard.array(forKey: "purchaseNames"))
        print(UserDefaults.standard.array(forKey: "purchaseAmounts"))
        print(UserDefaults.standard.array(forKey: "purchaseDates"))
        return cell
    }
*/
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.array(forKey: "purchaseAmounts")!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell
        cell.showCellData(name: UserDefaults.standard.array(forKey: "purchaseNames")?[indexPath.row] as! String, date: UserDefaults.standard.array(forKey: "purchaseDates")?[indexPath.row] as! String, amount: UserDefaults.standard.array(forKey: "purchaseAmounts")?[indexPath.row] as! Double)
        print("runs")
        return cell
    }
}
