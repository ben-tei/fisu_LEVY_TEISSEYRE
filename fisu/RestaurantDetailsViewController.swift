//
//  RestaurantDetailsViewController.swift
//  fisu
//
//  Created by vm mac on 17/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController, MKMapViewDelegate {
    
    var restaurant: Place?
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantAddress: UILabel!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let aRestaurant = self.restaurant
        {
            guard let restaurantName = aRestaurant.name else {
                return
            }
            guard let placeCategory = aRestaurant.placeCategory else {
                return
            }
            guard let placeCategoryName = placeCategory.name else {
                return
            }
            self.restaurantName.text = restaurantName + " (" + placeCategoryName + ")"
            self.restaurantAddress.text = aRestaurant.address
            guard let latitude = aRestaurant.latitude else {
                return
            }
            guard let longitude = aRestaurant.longitude else {
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
            self.myMapView.addAnnotation(annotation)
        }
        
        self.myMapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
