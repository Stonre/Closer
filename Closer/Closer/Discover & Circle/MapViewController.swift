//
//  MapViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/9.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
        // Do any additional setup after loading the view.
    }
//    var discoverView: UIView?
    var mapView: MKMapView?
    var discriptionLabel: UILabel?
    var mdRatio: CGFloat = 0.5
    
    var location = "765 Weyburn Terrace"
    
    private func addMapView() {
        mapView = MKMapView()
        view.addSubview(mapView!)
        
        mapView?.frame = CGRect(
            x: 0,
            y: UIApplication.shared.statusBarFrame.maxY,
            width: view.bounds.maxX,
            height: view.bounds.maxY * mdRatio
        )
    }
    
    private func addLabel() {
        discriptionLabel = UILabel()
        view.addSubview(discriptionLabel!)
        discriptionLabel?.frame = CGRect(
            x: 0,
            y: view.bounds.maxY * mdRatio,
            width: view.bounds.maxX,
            height: view.bounds.maxY * (1 - mdRatio)
        )
        discriptionLabel?.text = "This is an activity. \n"
        discriptionLabel?.textColor = UIColor.black

    }
    
    private func setupView() {
        self.title = "附近的任务"
        addMapView()
        addLabel()
        self.navigationController?.hidesBarsOnTap = true
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) in
            
            if error != nil {}
            else if let placemark = placemarks?[0] {
                let coordinate = placemark.location?.coordinate
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinate!
                pointAnnotation.title = self.location
                
                self.mapView?.addAnnotation(pointAnnotation)
                self.mapView?.centerCoordinate = coordinate!
                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                self.mapView?.setRegion(MKCoordinateRegion(center: coordinate!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
                
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKPinAnnotationView()
        pinView.annotation = annotation
        pinView.pinTintColor = UIColor.red
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
