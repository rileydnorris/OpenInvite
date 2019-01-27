//
//  MapControllerViewController.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/27/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    var cardInfo: [(User, Event)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setProfileImage()
        
        let eventsRef = db.collection("events")
        let _ = eventsRef.addSnapshotListener(updateEvents)
        
        let initialLocation = CLLocation(latitude: 30.627977, longitude: -96.3344068)
        centerMapOnLocation(location: initialLocation)
    }
    
    func setProfileImage() {
        let url = URL(string: user.imageURL)
        if let data = try? Data(contentsOf: url!) { profileButton.setImage(UIImage(data: data), for: UIControl.State.normal) }
    }
    
    func updateEvents(snapshot : QuerySnapshot?, error : Error?) {
        guard let documents = snapshot?.documents else {
            print("Error fetching documents: \(error!)")
            return
        }
        
        cardInfo.removeAll()
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        for doc in documents {
            let data = doc.data()
            let event = Event(data)
            getDocumentByID("users", data["hostID"] as! String) { (document, error) in
                let userData = document?.data()
                let user = User(userData ?? [:])
                self.cardInfo.append((user, event))
                self.setAnnotations()
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setAnnotations() {
        for (_, event) in cardInfo {
            let location = event.location
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(location) { [weak self] placemarks, error in
                if let placemark = placemarks?.first {
                    let mark = MKPlacemark(placemark: placemark)
                    self!.mapView.addAnnotation(mark)
                }
            }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            if let titleFirst = annotation.title {
                if let titleFinal = titleFirst {
                    for (_, event) in cardInfo {
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString(event.location) { [weak self] placemarks, error in
                            if let placemark = placemarks?.first {
                                let mark = MKPlacemark(placemark: placemark)
                                if let markTitle = mark.title {
                                    if markTitle == titleFinal {
                                        
                                        var imageURL = ""
                                        if (event.imageURL.isEmpty) {
                                            imageURL = "https://i.kym-cdn.com/entries/icons/original/000/016/212/manning.png"
                                        } else {
                                            imageURL = event.imageURL
                                        }
                                        
                                        annotationView.loadFromURL(urlString: imageURL)
                                        annotationView.image = self!.resizeImage(image: annotationView.image ?? UIImage(), newWidth: 75.0)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return annotationView
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}
