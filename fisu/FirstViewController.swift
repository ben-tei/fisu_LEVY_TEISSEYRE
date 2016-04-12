//
//  FirstViewController.swift
//  fisu
//
//  Created by vm mac on 10/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var activitiesSet = ActivitiesSet()
    
    var sectionsInTable = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.activitiesSet.getAllActivities() // Get all the activities from the database
        self.getSections()
        self.myTableView.reloadData()
        
    }
    
    // Browse the Activity Table to add sections (a section corresponds to a date)
    func getSections() { 
        
        for myActivity in self.activitiesSet.activities {
            guard let myActivityDate = myActivity.date else { // Retrieve the date
                return
            }
            
            if (!sectionsInTable.contains(myActivityDate)) {
                
                sectionsInTable.append(myActivityDate) // If the date isn't included, then we add it
            }
            
        }
    }
    
    // Add all the activities on the sections depending on their start date
    func getSectionActivities(section: Int) -> ActivitiesSet? {
        let sectionActivities = ActivitiesSet()
        for activity in self.activitiesSet.activities {
            
            if activity.date == sectionsInTable[section] as NSString {
                sectionActivities.addActivity(activity)
            }
        }
        
        return sectionActivities
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let select = UITableViewRowAction(style: .Normal, title: "Select",  handler: {action, index in
            guard let sectionActivities = self.getSectionActivities(indexPath.section) else {
                return
            }
            
            sectionActivities.getActivity(indexPath.row).register(1)
            
            self.myTableView.reloadData()
        })
        select.backgroundColor = UIColor.blueColor()
        return [select]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsInTable.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionActivities = self.getSectionActivities(section) else {
            return 0
        }
        return sectionActivities.count()
    }
    
    // Print the date as the section header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsInTable[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCellId", forIndexPath: indexPath) as! MyTableViewActivitiesCell
        
        // get the activities in this section
        guard let sectionActivities = self.getSectionActivities(indexPath.section) else {
            return cell
        }
        
        cell.myLabel.text = sectionActivities.getActivity(indexPath.row).name
        guard let startTime = sectionActivities.getActivity(indexPath.row).startTime else {
            return cell
        }
        guard let endTime = sectionActivities.getActivity(indexPath.row).endTime else {
            return cell
        }
        cell.myTimeLabel.text = startTime + " - " + endTime
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSegueActivityDetails"
        {
            if let indexPath = self.myTableView.indexPathForSelectedRow
            {
                let nav = segue.destinationViewController as! UINavigationController
                let viewController = nav.topViewController as! ActivityDetailsViewController
                // get the activities in this section
                guard let sectionActivities = self.getSectionActivities(indexPath.section) else {
                    return
                }
                viewController.activity = sectionActivities.getActivity(indexPath.row)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}