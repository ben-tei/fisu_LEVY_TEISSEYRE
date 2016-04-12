//
//  SecondViewController.swift
//  fisu
//
//  Created by vm mac on 10/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class SecondViewController: UIViewController, MKMapViewDelegate {
    
    var placesSet = PlacesSet()
    
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placesSet.getAllPlaces()
        
        for aPlace in self.placesSet.places {
            
            guard let latitude = aPlace.latitude else {
                return
            }
            guard let longitude = aPlace.longitude else {
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
            annotation.title = aPlace.name
            guard let category = aPlace.placeCategory else {
                return
            }
            guard let name = category.name else {
                return
            }
            annotation.subtitle = name
            self.myMapView.addAnnotation(annotation)
        }
        
        self.myMapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
