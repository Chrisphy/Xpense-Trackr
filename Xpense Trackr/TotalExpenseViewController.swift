//
//  TotalExpenseViewController.swift
//  Xpense Trackr
//
//  Created by CHRIS CHONG on 15/05/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import UIKit

class TotalExpenseViewController: UIViewController {
    
    var newExpenseTotal: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
NotificationCenter.default.addObserver(self, selector: Selector(("refreshlbl:")), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        // Do any additional setup after loading the view.
    }       

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var totalExpenseLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
