//
//  LocationProfileViewController.swift
//  PupsAndPlaygrounds
//
//  Created by Robert Deans on 11/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationProfileViewController: UIViewController {
    
    var locationProfileView: LocationProfileView!
    let store = LocationsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        store.getDogrunsAndPlaygrounds()
        
        navigationItem.title = "Location"
        navigationController?.isNavigationBarHidden = false
        
        locationProfileView = LocationProfileView()
        view = locationProfileView
        locationProfileView.submitButton.addTarget(self, action: #selector(submitReviewAlert), for: .touchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitReviewAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)    }
    
}
