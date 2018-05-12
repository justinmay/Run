//
//  MapViewController.swift
//  Run
//
//  Created by Justin May on 5/11/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import Mapbox
import Firebase

class MapViewController: UIViewController, MGLMapViewDelegate{

    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var themap: MGLMapView!
    
    var button : UIButton?
    
    var x = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.styleURL = MGLStyle.lightStyleURL
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map’s center coordinate and zoom level.
        view.addSubview(mapView)
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        // Set the delegate property of our map view to `self` after instantiating it.
        mapView.delegate = self
        
        // Declare the marker and set its coordinates,
        let hello = MGLPointAnnotation()
        
        hello.coordinate = CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407)
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(hello)
        
        button = UIButton(frame: CGRect(x: self.view.frame.maxX - 80, y: self.view.frame.maxY - 80, width: 50, height: 50))
        button?.backgroundColor = UIColor.purple
        button?.setTitle("Start", for: .normal)
        button?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button?.layer.cornerRadius = 0.5 * (button?.frame.width)!;
        
        self.view.addSubview(button!)
    }

    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
//        let ref = Database.database().reference(fromURL: "https://runcodingchallenge.firebaseio.com/")
//        let usersReference = ref.child("users").child(uid)
//        let values = ["names": userName, "email": email,"password": password]
//        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//
//            if err != nil {
//                print(err)
//                return
//            }
//
//            print("saved user successfully into firebase db")
//        })
        if x % 2 == 1 {
            button?.setTitle("Stop", for: .normal)
        } else {
            button?.setTitle("Start", for: .normal)
            
        }
        x = x + 1
        
        
    }

}
