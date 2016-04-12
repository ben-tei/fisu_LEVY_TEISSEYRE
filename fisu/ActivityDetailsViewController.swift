//
//  ActivityDetailsViewController.swift
//  fisu
//
//  Created by vm mac on 12/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ActivityDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    var activity: Activity?
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var myLabelActivityDetail: UILabel!
    
    @IBOutlet weak var myImageActivityDetail: UIImageView!
    
    @IBOutlet weak var myDescriptionActivityDetail: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var mySpeakers = SpeakersSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let anActivity = self.activity
        {
            guard let activityName = anActivity.name else {
                return
            }
            guard let activityCategory = anActivity.activityCategory else {
                return
            }
            guard let activityCategoryName = activityCategory.name else {
                return
            }
            self.myLabelActivityDetail.text = activityName + " (" + activityCategoryName + ")"
            self.myDescriptionActivityDetail.text = anActivity.summary
            guard let image = anActivity.image else {
                return
            }
            self.myImageActivityDetail.image = UIImage(data:image, scale:1.0)
            guard let speakersNSSet = anActivity.speakers else {
                return
            }
            guard let speakersArray = speakersNSSet.allObjects as? [Speaker] else {
                return
            }
            self.mySpeakers.speakers = speakersArray
            guard let place = anActivity.place else {
                return
            }
            guard let latitude = place.latitude else {
                return
            }
            guard let longitude = place.longitude else {
                return
            }
            let location = CLLocationCoordinate2D(
                latitude: (latitude as NSString).doubleValue,
                longitude: (longitude as NSString).doubleValue
            )
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            self.myMapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = place.name
            guard let placeCategory = place.placeCategory else {
                return
            }
            guard let placeCategoryName = placeCategory.name else {
                return
            }
            annotation.subtitle = placeCategoryName
            self.myMapView.addAnnotation(annotation)
            
            if(anActivity.registered == true)
            {
                self.mySwitch.setOn(true, animated:true)
            }
        }
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.myTableView.reloadData()
        self.myMapView.delegate = self
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
        return self.mySpeakers.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mySpeakerCellId", forIndexPath: indexPath) as! MyTableViewSpeakersCell
        
        let speaker = self.mySpeakers.getSpeaker(indexPath.row)
        guard let name = speaker.valueForKey("name") as? String else {
            return cell
        }
        guard let firstname = speaker.valueForKey("firstname") as? String else {
            return cell
        }
        cell.myLabel.text = name.uppercaseString + " " + firstname.capitalizedString
        guard let image = speaker.valueForKey("image") else {
            return cell
        }
        cell.myImage.image = UIImage(data:image as! NSData, scale:1.0)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSegueSpeaker"
        {
            if let indexPath = self.myTableView.indexPathForSelectedRow
            {
                let nav = segue.destinationViewController as! UINavigationController
                let viewController = nav.topViewController as! SpeakerDetailsViewController
                viewController.speaker = self.mySpeakers.getSpeaker(indexPath.row)
                
            }
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func setRegistered(sender: AnyObject) { // Corresponds to the button to push to register
        guard let activity = self.activity else {
            return
        }
        activity.register(mySwitch.on) // Get the Activity & Add it to the "My Activities" Page
    }
    
}
