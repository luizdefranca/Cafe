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

    //MARK: Lifecicle Methods


    override func viewDidLoad() {
        super.viewDidLoad()
        showMapAnnotations()

    }
    
    //MARK: Private Methods

    private func showMapAnnotations(){
        if let cafeAnnotation = cafe {
            mapView.addAnnotation(cafeAnnotation)
            let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
            let region = MKCoordinateRegion(center: cafeAnnotation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            mapView.showAnnotations([cafeAnnotation], animated: true)
            mapView.selectAnnotation(cafeAnnotation, animated: true)
        }
    }

}

//MARK: Extensions
