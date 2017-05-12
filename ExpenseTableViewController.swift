//
//  ExpenseTableViewController.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 5/05/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit
import os.log

class ExpenseTableViewController: UITableViewController {
    var expenses = [Expenses]();
    
    
    override func viewDidLoad() {
        
        //This creates an edit button on the left for deleting items from the list
        navigationItem.leftBarButtonItem = editButtonItem
        
        
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
    
    
<<<<<<< HEAD
    
=======
    /*
>>>>>>> 59d5f2acc009af827b4a660b855f4b2567b08ab3
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
                os_log("New expense", log:OSLog.default, type: .debug)
            
        case "ShowDetails":
            guard let ExpenseDetailsViewController = segue.destination as? ExpenseViewController else {
                fatalError("Unexpected segue destination: \(segue.destination)")
            }
            
            guard let selectedExpenseCell = sender as? ExpenseTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedExpenseCell) else {
                fatalError("Error showing a cell")
            }
            
            let selectedExpense = expenses[indexPath.row]
            ExpenseDetailsViewController.expense = selectedExpense
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
<<<<<<< HEAD
 
=======
    */
>>>>>>> 59d5f2acc009af827b4a660b855f4b2567b08ab3
    
    @IBAction func unwindList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ExpenseViewController, let expense = sourceViewController.expense {
            
<<<<<<< HEAD
            if let selectedIndex = tableView.indexPathForSelectedRow {
                // Update existing data.
                expenses[selectedIndex.row] = expense
                tableView.reloadRows(at: [selectedIndex], with: .none)
            }
            else {
                // New expense.
                let newIndexPath = IndexPath(row: expenses.count, section: 0)
                
                expenses.append(expense)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }

    }
    
=======
            // Add a new meal.
            let newIndexPath = IndexPath(row: expenses.count, section: 0)
            
            expenses.append(expense)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
>>>>>>> 59d5f2acc009af827b4a660b855f4b2567b08ab3
    private func loadSamples(){
        let photo1 = UIImage(named: "defaultPhoto")
        
        guard let expense1 = Expenses(name: "Groceries for mum", photo: photo1, value: 14.50) else {
            fatalError("Unable to instantiate expense1 (Test)")
        }
        
        expenses += [expense1]
    }
    
    
    

}
