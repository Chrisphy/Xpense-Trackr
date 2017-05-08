//
//  ExpenseTableViewController.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 5/05/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit

class ExpenseTableViewController: UITableViewController {
    var expenses = [Expenses]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //samples init
        
        loadSamples()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ExpenseTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExpenseTableViewCell else {
            fatalError("Dequeuedcell is not an instance of ExpenseTableViewCell")
        }
        
        let expense = expenses[indexPath.row]
        
        cell.nameLabel.text = expense.name
        cell.expenseLabel.text = String(expense.expenseValue)
        cell.photoImage.image = expense.photo
        // Configure the cell...

        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ExpenseViewController, let expense = sourceViewController.expense {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: expenses.count, section: 0)
            
            expenses.append(expense)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    private func loadSamples(){
        let photo1 = UIImage(named: "defaultPhoto")
        
        guard let expense1 = Expenses(name: "Groceries for mum", photo: photo1, value: 14.50) else {
            fatalError("Unable to instantiate expense1 (Test)")
        }
        
        expenses += [expense1]
    }
    
    
    

}
