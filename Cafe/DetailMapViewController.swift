//
//  MapViewController.swift
//  Cafe
//
//  Created by Luiz on 11/8/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit
import MapKit

class DetailMapViewController: UIViewController {


    //MARK: Outlets

    @IBOutlet weak var mapView: MKMapView!

    //MARK: Properties
    var cafe: Cafe?

    //Constants
     let annotationIdentifier = "CafePin"

    //MARK: Lifecicle Methods


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationItem.title = cafe?.address
        showMapAnnotations()

    }
    
    //MARK: Private Methods

    private func showMapAnnotations(){
        if let cafeAnnotation = cafe {
            mapView.addAnnotation(cafeAnnotation)
            let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
            let region = MKCoordinateRegion(center: cafeAnnotation.coordinate, span: span)
            cafeAnnotation.title = cafeAnnotation.name
            mapView.showsScale = true
            mapView.showsCompass = true
//            mapView.showsUserLocation = true
//            mapView.showsPointsOfInterest = false

            let scale = MKScaleView(mapView: mapView)
//            scale.translatesAutoresizingMaskIntoConstraints = false
            scale.scaleVisibility = .visible

            mapView.addSubview(scale)
            scale.center = CGPoint(x: (scale.frame.width / 2) + 16  , y: (scale.frame.height / 2) + 100)

//            let bottonAnchorConstraint = scale.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 40)
//            let leadingAnchorConstraint = scale.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 40)
//
//            let widthConstraint = scale.widthAnchor.constraint(equalToConstant: mapView.frame.width / 3)
//            mapView.addConstraints([bottonAnchorConstraint,leadingAnchorConstraint])
//
            
            let compass = MKCompassButton(mapView: mapView)
            compass.translatesAutoresizingMaskIntoConstraints = false
            compass.compassVisibility = .visible
            mapView.addSubview(compass)
//            compass.center = CGPoint(x: (mapView.frame.maxX) - ( (compass.frame.width / 2) + 16), y: (scale.frame.height / 2) + 100)

            mapView.addConstraints([compass.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 100), compass.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16)])

            mapView.setRegion(region, animated: true)
            mapView.showAnnotations([cafeAnnotation], animated: true)
            mapView.selectAnnotation(cafeAnnotation, animated: true)

        }
    }

}

//MARK: Extensions

//MARK: MapViewDelegate
extension DetailMapViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation.isKind(of: MKUserLocation.self) { return nil}

        //Reusing annotation if possible
        var annotationView : MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: self.annotationIdentifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }

        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        if let image : UIImage = cafe?.image {
            print("ok")
        } else {
            print("bad")
        }
        leftIconView.image = cafe?.image

        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.layer.shadowColor = UIColor.gray.cgColor
        annotationView?.layer.shadowOffset = CGSize(width: 3, height: 3)
        annotationView?.layer.shadowRadius = 0.7
        annotationView?.layer.shadowOpacity = 0.6
        mapView.showsCompass = true
        return annotationView
    }
}
