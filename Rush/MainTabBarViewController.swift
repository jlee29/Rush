//
//  MainTabBarViewController.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/21/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    private var orderTVC: OrdersTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTVC = self.childViewControllers[0] as? OrdersTableViewController
        let rushModel = RushModel()
        rushModel.retrieveFromDatabase(handler: handleOrderRetrieval)

        print("view did load")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleOrderRetrieval(orderList: [Order] ) {
        orderTVC?.orders = orderList
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
