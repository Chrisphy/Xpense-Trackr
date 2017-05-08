//
//  Expenses.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 1/05/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit

class Expenses {
    
    var name: String
    var photo: UIImage?
    var expenseValue: Double
    
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, value: Double) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        guard (value > 0) else{
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.expenseValue = value
    }
    
    
    
}
