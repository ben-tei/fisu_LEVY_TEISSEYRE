//
//  RestaurantsViewController.swift
//  fisu
//
//  Created by vm mac on 17/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import CoreData

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var restaurantsSet = PlacesSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.restaurantsSet.getAllRestaurants()
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many rows are there in this section?
        // There's only 1 section, and it has a number of rows
        // equal to the number of activities, so return the count
        return self.restaurantsSet.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myRestaurantCellId", forIndexPath: indexPath) as! MyTableViewRestaurantsCell
        
        let restaurant = self.restaurantsSet.getPlace(indexPath.row)
        cell.myLabel.text = restaurant.name
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSegueRestaurantDetails"
        {
            if let indexPath = self.myTableView.indexPathForSelectedRow
            {
                let nav = segue.destinationViewController as! UINavigationController
                let viewController = nav.topViewController as! RestaurantDetailsViewController
                viewController.restaurant = self.restaurantsSet.getPlace(indexPath.row)
                
            }
        }
    }
    
}
