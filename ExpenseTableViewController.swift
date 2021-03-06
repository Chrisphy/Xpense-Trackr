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
    var currentValue: Double!

    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //This creates an edit button on the left for deleting items from the list
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedData = loadData() {
            expenses += savedData
        }
        else {
            //samples init
            loadSamples()

        }
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
        
        //set cell values
        cell.nameLabel.text = expense.name
        cell.expenseLabel.text = String(format: "%.2f", expense.expenseValue)
        cell.photoImage.image = expense.photo
        
        //set label
        if let temp = Double(totalLabel.text!) {
            print("The current total is \(temp)")
            currentValue = ((Double(temp)) * 100).rounded() / 100
        } else {
            print("Not a valid number: \(totalLabel.text!)")
            currentValue = 0.00
        }
        
        let new = Double(expense.expenseValue)
        
        if(currentValue <= new) {
        totalLabel.text = String(format: "%.2f", (currentValue + new))
        }
        else{
        totalLabel.text = String(format: "%.2f", (currentValue + new))

        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let expense = expenses[indexPath.row]
            
            if let temp = Double(totalLabel.text!) {
                print("The current total is \(temp)")
                currentValue = ((Double(temp)) * 100).rounded() / 100
            } else {
                print("Not a valid number: \(totalLabel.text!)")
                currentValue = 0.00
            }
 
            let new = Double(expense.expenseValue)
            
            totalLabel.text = String(format: "%.2f", (currentValue - new))
            
            expenses.remove(at: indexPath.row)
            
            if expenses.isEmpty {
                totalLabel.text = String(format: "%.2f", (0))
            }

            save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

        
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //move the items in the list
        let expense_move = expenses[fromIndexPath.row]
        expenses.remove(at: fromIndexPath.row)
        expenses.insert(expense_move, at: destinationIndexPath.row)
        
        print("Moved successfully!")
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    //preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
                print("New expense")
            
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
 
    
    @IBAction func unwindList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ExpenseViewController, let expense = sourceViewController.expense {
            
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
            save()
        }

    }
    
    
    
    
    
    private func loadSamples(){
        let photo1 = UIImage(named: "defaultPhoto")
        
        guard let expense1 = Expenses(name: "Groceries for mum", photo: photo1, value: 14.50) else {
            fatalError("Unable to instantiate expense1 (Test)")
        }
        
        expenses += [expense1]
    }
    
    private func save(){
        let Success = NSKeyedArchiver.archiveRootObject(expenses, toFile: Expenses.Archive.path)
        if Success {
            print("Successfully saved.")
        } else {
            print("Failed to save")
        }
    }
    
    private func loadData() -> [Expenses]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Expenses.Archive.path) as? [Expenses]
    }
    

}
