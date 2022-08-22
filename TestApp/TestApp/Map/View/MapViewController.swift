//
//  MapViewController.swift
//  TestApp
//
//  Created by Saurabh Shukla on 23/08/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    var viewModel: MapViewModelProtocal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocation(latitude: CLLocationDegrees(viewModel.address.geo.lat) ?? 0, longitude: CLLocationDegrees(viewModel.address.geo.lng) ?? 0)
        let mark = MKPlacemark(coordinate: location.coordinate)
        
        var region = mapView.region
        
        region.center = location.coordinate
        region.span.longitudeDelta /= 8.0
        region.span.latitudeDelta /= 8.0
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(mark)
    }
}
