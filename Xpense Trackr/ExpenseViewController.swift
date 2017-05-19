//
//  ViewController.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 28/04/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit
import os.log

class ExpenseViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //MARK:  Properties
 
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var expense : Expenses?
    var expenseValue: Double = 0.00
    var currentValue: Double!
    var addition_result : Double = 0.00

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        expenseTextField.delegate = self
        amountTextField.keyboardType = UIKeyboardType.decimalPad
        
        
        if let expense = expense {
            navigationItem.title = expense.name
            expenseTextField.text = expense.name
            photoImageView.image = expense.photo
            amountTextField.text = String(expense.expenseValue)
        }
        
        
        updateSaveButton()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable save
        saveButton.isEnabled = false

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
        navigationItem.title = textField.text
    }
    
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //Navigation controls
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = expenseTextField.text ?? ""
        let photo = photoImageView.image
        
        let amount_text = amountTextField.text ?? ""
        if(name.isEmpty == true && amount_text.isEmpty == true){
            saveButton.isEnabled = false
        }
        else if (name.isEmpty == false && amount_text.isEmpty == true){
            let alert = UIAlertController(title: "Error", message: "You did not fill out the amount field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        else if (name.isEmpty == true && amount_text.isEmpty == false)
        {
            let alert = UIAlertController(title: "Error", message: "You did not fill out the text field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        else {
            if let temp = amountTextField.text{
                expenseValue = Double(temp)!
                expenseValue = ((expenseValue) * 100).rounded() / 100
            }
            expense = Expenses(name: name, photo: photo, value: expenseValue)
        }
        
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let currentViewControllerIsAdd = presentingViewController is UITabBarController
        
        if currentViewControllerIsAdd {
            dismiss(animated: true, completion: nil)

        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("No Expense View Controller (adding/updating) view controller is active")
        }
    }
    
    private func updateSaveButton(){
        // Disable 
        let text = expenseTextField.text ?? ""

        saveButton.isEnabled = !text.isEmpty
        
    }
    


    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        
        
        // Hide the keyboard.
        expenseTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        // Replace .photoLibary with .camera for camera access (unable to emulate)
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func clearKeyboard(_ sender: Any) {
        expenseTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
        
    }

    @IBAction func fiveDollars(_ sender: Any) {
        
        if let temp = Double(amountTextField.text!) {
            print("The user entered a value price of \(temp)")
            currentValue = ((Double(temp)) * 100).rounded() / 100
        } else {
            print("Not a valid number: \(amountTextField.text!)")
            currentValue = 0.00
        }
        
        
        addition_result = (currentValue + 5.00)
        
        amountTextField.text = String(format: "%.2f", addition_result)
        
    }
    
    @IBAction func fifteenDollars(_ sender: Any) {
        if let temp = Double(amountTextField.text!) {
            print("The user entered a value price of \(temp)")
            currentValue = ((Double(temp)) * 100).rounded() / 100
        } else {
            print("Not a valid number: \(amountTextField.text!)")
            currentValue = 0.00
        }
        
        
        addition_result = (currentValue + 15.00)
        
        amountTextField.text = String(format: "%.2f", addition_result)
        

    }
 
    @IBAction func clearButton(_ sender: Any) {
        amountTextField.text = ""
        expenseTextField.text = ""
        photoImageView.image = UIImage (named: "defaultPhoto")
    }

    
    
}

    


