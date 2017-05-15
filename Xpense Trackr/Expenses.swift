//
//  Expenses.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 1/05/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit
import os.log

class Expenses : NSObject, NSCoding {
    
    //Storage Paths
    static let Directory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let Archive = Directory.appendingPathComponent("expenses")
    
    
    struct propertyKey {
        static let name = "name"
        static let photo = "photo"
        static let expenseValue = "value"
        
    }
    
    
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
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(photo, forKey: propertyKey.photo)
        aCoder.encode(expenseValue, forKey: propertyKey.expenseValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: propertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: propertyKey.photo) as? UIImage
        
        let expenseValue = aDecoder.decodeDouble(forKey: propertyKey.expenseValue)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, value: expenseValue)
        
        
    }
}


