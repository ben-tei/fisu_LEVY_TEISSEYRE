//
//  SpeakerDetailsViewController.swift
//  fisu
//
//  Created by vm mac on 12/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit

class SpeakerDetailsViewController: UIViewController {
    
    var speaker: Speaker?
    
    @IBOutlet weak var mySpeakerName: UILabel!
    
    @IBOutlet weak var mySpeakerImage: UIImageView!
    
    @IBOutlet weak var mySpeakerAbout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let aSpeaker = self.speaker
        {
            guard let name = aSpeaker.name else {
                return
            }
            guard let firstname = aSpeaker.firstname else {
                return
            }
            self.mySpeakerName.text = name.uppercaseString + " " + firstname.capitalizedString
            self.mySpeakerAbout.text = aSpeaker.about
            guard let image = aSpeaker.image else {
                return
            }
            self.mySpeakerImage.image = UIImage(data:image, scale:1.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
