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
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        enableLocationManager()
        setupView()
        // Do any additional setup after loading the view.
    }
//    var discoverView: UIView?
    var mapView: MKMapView?
    var discriptionLabel: UILabel?
    var activityReviewController: BriefActivityReviewViewController?
    var mdRatio: CGFloat = 0.5
    var activities = [Activity]()
    var selfLocation: CLLocation!
    
    var locationManager: CLLocationManager?
    var lastRegion: MKCoordinateRegion?
    var selfLocationAnnotation = MKPointAnnotation()
    
    var location = "765 Weyburn Terrace"
    
    private func addMapView() {
        mapView = MKMapView()
        view.addSubview(mapView!)
        mapView?.delegate = self
        mapView?.isUserInteractionEnabled = true
        mapView?.region.span.longitudeDelta = 0.01
        mapView?.region.span.latitudeDelta = 0.01
        mapView?.addAnnotation(selfLocationAnnotation)
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
        discriptionLabel?.numberOfLines = 7
        discriptionLabel?.text = "This is an activity. \n"
        discriptionLabel?.textColor = UIColor.black
    }
    
    private func addActivityReviewViewController() {
        activityReviewController = BriefActivityReviewViewController()
        self.addChildViewController(activityReviewController!)
        activityReviewController?.view.frame = (discriptionLabel?.frame)!
        activityReviewController?.view.backgroundColor = .white
        view.addSubview((activityReviewController?.view)!)
    }
    
    private func setupView() {
        self.title = "附近的任务"
        addMapView()
        addLabel()
        addActivityReviewViewController()
//        self.navigationController?.hidesBarsOnTap = true
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) in
//            
//            if error != nil {}
//            else if let placemark = placemarks?[0] {
//                let coordinate = placemark.location?.coordinate
//                let pointAnnotation = ActivityMKAnnotationView()
//                pointAnnotation.coordinate = coordinate!
//                pointAnnotation.title = self.location
//                
//                self.mapView?.addAnnotation(pointAnnotation)
//                self.mapView?.centerCoordinate = coordinate!
//                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
//                self.mapView?.setRegion(MKCoordinateRegion(center: coordinate!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
//                
//            }
//        })
    }
    
    private func setPointPinsForActivities() {
        for activity in activities {
            if let act = activity as? GeneralActivity {
                if let location = act.location {
                    let pointAnnotation = ActivityMKPointAnnotation()
                    pointAnnotation.coordinate = location.coordinate
                    pointAnnotation.title = act.name
                    
                    self.mapView?.addAnnotation(pointAnnotation)
                }
            }
        }
    }
    
    private func loadActivities() {
        let ref = FIRDatabase.database().reference().child("geo-activities")
        ref.observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary ?? NSDictionary()
            for (_, activityLocation) in value {
                if let actLoca = activityLocation as? NSDictionary {
                    let activity = actLoca["activity"] as? NSDictionary ?? NSDictionary()
                    let location = actLoca["location"] as? NSDictionary ?? NSDictionary()
                    guard let name = activity["name"] as? String, let description = activity["discription"] as? String,
                    let longitude = location["longitude"] as? Double, let latitude = location["latitude"] as? Double
                        else {
                            return
                    }
                    let annotation = ActivityMKPointAnnotation()
                    annotation.activityDescription = description
                    annotation.coordinate.longitude = longitude
                    annotation.coordinate.latitude = latitude
                    annotation.title = name
                    let descriptiont: [DescriptionUnit]
                    let description4 = DescriptionUnit(type: ContentType.Text, content: "让我们加入明天的Closer的活动吧，我认为这太兴奋了。任何人如果想加入，不要犹豫，我们欢迎你！具体的活动内容如下：\n1.跟大神王凯铭学长讨论学（duan）术（zi）问题。2.跟Closer创始团队讨论创业经历")
                    let description5 = DescriptionUnit(type: ContentType.Image, content: "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b")
                    let description6 = DescriptionUnit(type: ContentType.Hyperlink, content: "上海交通大学::::::http://vol.sjtu.edu.cn/newalpha/")
                    descriptiont = [description4, description5, description6]
                    let user = PersonalUserForView(userName: "丁磊", userId: "4", gender: Gender.Female, age: 22)
                    user.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait2.png?alt=media&token=fc65090f-fd7a-47f3-8a6a-bb4def659c32"
                    annotation.activity = GeneralActivity(name: name, tags: ["hh"], authority: .Public, description: descriptiont, userReleasing: user, identity: "hh")
                    annotation.activity?.timeStart = Date()
                    self.mapView?.addAnnotation(annotation)
                }
            }
        }, withCancel: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView()
        pinView.annotation = annotation
        if let _ = annotation as? ActivityMKPointAnnotation {
            pinView.pinTintColor = UIColor.blue
        } else {
            pinView.pinTintColor = UIColor.red
        }
        pinView.animatesDrop = true
//        pinView.canShowCallout = true
//        pinView.isUserInteractionEnabled = true
//        pinView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOn(annotation:))))
        
        pinView.leftCalloutAccessoryView = pinView
        
        return pinView
    }
    
//    func tapOn(annotation: MKAnnotation) {
//        if let anno = annotation as? MKPointAnnotation {
//             discriptionLabel?.text = anno.title
//        }
//    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let anno = view.annotation as? ActivityMKPointAnnotation {
            activityReviewController?.activity = anno.activity
        }
//        mapView.addAnnotation(view.annotation!)
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        discriptionLabel?.text = (view.annotation?.title)!
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
        locationManager?.stopUpdatingLocation()
    }
    
    private func enableLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        selfLocation = locations.last! as CLLocation
        guard let latitude = selfLocation?.coordinate.latitude, let longitude = selfLocation?.coordinate.longitude
            else {
                return
        }
        
        setSelfLocationPin()
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: (mapView?.region.span.latitudeDelta)!, longitudeDelta: (mapView?.region.span.longitudeDelta)!))
        
        if lastRegion == nil {
//            addActivities()
            mapView?.setRegion(region, animated: true)
            loadActivities()
            lastRegion = region
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        loadActivities()
//    }
    
    private func setSelfLocationPin() {
        selfLocationAnnotation.coordinate = (selfLocation?.coordinate)!
        selfLocationAnnotation.title = "我的位置"
//        self.mapView?.addAnnotation(pointAnnotation)
    }
    
    private func addActivities() {
        let user = FIRAuth.auth()?.currentUser
        guard let currUserName = user?.displayName, let currUserId = user?.uid
            else {
                return
        }
        for i in 1...15 {
            let ref = FIRDatabase.database().reference().child("geo-activities")
            let key = ref.childByAutoId().key
            let description = DescriptionUnit(type: .Text, content: "This is Activity \(i) ")
            let generalActivity = GeneralActivity(name: "Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: [description], userReleasing: PersonalUserForView(userName: "User \(i)", userId: currUserId, gender: Gender.Female, age: 18), identity: key)
            var randomDistance = (Double(arc4random()) / Double(UINT32_MAX) - 0.5) / 50.0
            let longitude = selfLocation.coordinate.longitude.advanced(by: randomDistance)
            randomDistance = (Double(arc4random()) / Double(UINT32_MAX) - 0.5) / 50.0
            let latitude = selfLocation.coordinate.latitude.advanced(by: randomDistance)
            generalActivity.location = CLLocation(latitude: latitude, longitude: longitude)
            let activity = ["releasingUserID": currUserId,
                            "releasingUserName": currUserName,
                            "name": generalActivity.name,
                            "description": generalActivity.description.first?.content]
            let location = ["longitude": longitude,
                            "latitude": latitude]
            let updates = ["/\(key)/activity": activity,
                           "/\(key)/location": location] as [String : Any]
            ref.updateChildValues(updates, withCompletionBlock: { (error, ref) in
                if error != nil {
                    return
                }
            })

        }
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
