//
//  ViewController.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 28/04/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //MARK:  Properties
 
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    var expenseValue: Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        expenseTextField.delegate = self
        amountTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
    


    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        
        
        // Hide the keyboard.
        expenseTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func setExpenseButton(_ sender: UIButton) {
        
        if let temp = amountTextField.text{
        expenseValue = Double(temp)!
        expenseValue = ((expenseValue) * 100).rounded() / 100
        }
        else{
        expenseValue = 0
        }
      //  expenseLabel.text = "Expense: \(expenseValue)"

        
        
        
        
        
        
        
    }
}

