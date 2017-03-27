//
//  ViewController.swift
//  Current Location - Xcode 6.3.1
//  Location controller which handles all the locations related processing for displaying the Map related info
//  Created by Darshan Masti Prakash,Manjunath Babu 
//  Info.plist - NSLocationWhenInUseUsageDescription

import UIKit
import CoreLocation
import MapKit

//controller class which implements protocols to handle Map related processing
class LocationController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
{
    var searchQuery : String = "" //searchQuery
    var noOfMiles : String  = "" // radius for which search to be performed
    var noOfRes :Int = 5    // number of items in the dropdown
    @IBOutlet var mapView: MKMapView!   //map view
    let locationManager = CLLocationManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.delegate = self
        let prefs = NSUserDefaults.standardUserDefaults()
        if let searchQ = prefs.stringForKey("CATEGORY"){
            searchQuery = searchQ
            print("The user has a category: " + searchQuery)
        }else{
            searchQuery = "Restaurants"
        }
        if let nmiles = prefs.stringForKey("MILES") {
            noOfMiles = nmiles
            print("The user has a radius : " + noOfMiles)
        }else{
            noOfMiles = "1600"        }
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()    //start updating location related information
        self.mapView.showsUserLocation = true
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //called when the location coordinates are received
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.locationManager.stopUpdatingLocation() //finished obtaining the location now stop updating location
        self.GetSearchResults(locValue)
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }
    
    //assign the buttons to the pin annotations and custom styling on the same
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pin!.pinTintColor = UIColor.greenColor()
            pin!.canShowCallout = true
            pin!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            pin!.annotation = annotation
        }
        return pin
    }
    //event called when a pin has been clicked
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
               print(annotationView.annotation!.title) // annotation's title
               let title = annotationView.annotation!.title
               let subtitle = annotationView.annotation!.subtitle
               //split to get the url and name from the title
               let fullTitleArr = title!!.characters.split{$0 == ";"}.map(String.init)
               print(fullTitleArr[0] )// Name
               print(fullTitleArr[1]) // PhoneNo
               let aString: String = fullTitleArr[0]
               let newString = aString.stringByReplacingOccurrencesOfString("Optional(", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
                //extract the phone number
                let aString1: String = fullTitleArr[1]
                let newString1 = aString1.stringByReplacingOccurrencesOfString("Optional(", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
                //extract the subtitle i.e the url to be displayed
                let aString2: String = subtitle!!
                let newString2 = aString2.stringByReplacingOccurrencesOfString("Optional(", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
               NSUserDefaults.standardUserDefaults().setObject(newString, forKey: "Title")
               NSUserDefaults.standardUserDefaults().setObject(newString1, forKey: "PhoneNo")
               NSUserDefaults.standardUserDefaults().setObject(newString2, forKey: "Subtitle")
               performSegueWithIdentifier("goto_singlepin", sender: view)
        }
    }
    
    //used to center the map on the location radius
    func centerMapOnLocation(location: MKPointAnnotation, regionRadius: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //search query on the user input for the nearby places search. MapKit search query
    func GetSearchResults(c: CLLocationCoordinate2D)
    {
        let request = MKLocalSearchRequest()    //local search request
        let location = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
        request.naturalLanguageQuery = searchQuery
        let x: Double = Double(noOfMiles)! //north-south or east -west distance
        request.region = MKCoordinateRegionMakeWithDistance(location,x,x)
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = location
        centerMapOnLocation(annotation1, regionRadius: x+1000)  //assign the radius of the center location to concentrate on
        MKLocalSearch(request: request).startWithCompletionHandler { (response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                var count: Int = 0
                var collMapItems: [MKMapItem] = []
                for item in response!.mapItems{ //response obtained
                    if(count > self.noOfRes)
                    {
                        break
                    }
                    collMapItems.append(item)   //append each of the items to the map collection
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    print("Address = \(item.url)")
                    _ = item.placemark;
                    count += 1
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate //lat and long coodinates
                    let name: String = item.name!
                    annotation.subtitle = String(item.url)
                    annotation.title = name + ";"+String(item.phoneNumber)
                    self.mapView.addAnnotation(annotation) //add annotation to the map
                }
            }
        }
    }
}

