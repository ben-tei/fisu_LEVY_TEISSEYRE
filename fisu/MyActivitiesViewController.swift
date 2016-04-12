//
//  MyActivitiesViewController.swift
//  fisu
//
//  Created by vm mac on 17/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import CoreData

class MyActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var myActivities = ActivitiesSet()
    
    var sectionsInTable = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.myActivities.getMyActivities()
        self.getSections()
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSections() {
        self.sectionsInTable = [String]()
        
        for myActivity in self.myActivities.activities {
            guard let myActivityDate = myActivity.date else {
                return
            }
            if (!sectionsInTable.contains(myActivityDate)) {
                sectionsInTable.append(myActivityDate)
            }
            
        }
    }
    
    func getSectionActivities(section: Int) -> ActivitiesSet? {
        let sectionActivities = ActivitiesSet()
        for myActivity in self.myActivities.activities {
            if myActivity.date == sectionsInTable[section] as NSString {
                sectionActivities.addActivity(myActivity)
            }
        }
        
        return sectionActivities
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
        let cell = tableView.dequeueReusableCellWithIdentifier("myActivityCellId", forIndexPath: indexPath) as! MyTableViewMyActivitiesCell
        
        // Get the activities in this section
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            guard let sectionActivities = self.getSectionActivities(indexPath.section) else {
                return
            }
            
            sectionActivities.getActivity(indexPath.row).register(0)
            
            self.myActivities.getMyActivities()
            self.getSections()
            self.myTableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "secondIdSegueActivityDetails"
        {
            if let indexPath = self.myTableView.indexPathForSelectedRow
            {
                let nav = segue.destinationViewController as! UINavigationController
                let viewController = nav.topViewController as! ActivityDetailsViewController
                // Get the activities in this section
                guard let sectionActivities = self.getSectionActivities(indexPath.section) else {
                    return
                }
                viewController.activity = sectionActivities.getActivity(indexPath.row)
                
            }
        }
    }
    
}
