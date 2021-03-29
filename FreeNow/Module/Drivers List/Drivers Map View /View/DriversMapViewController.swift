//
//  DriversMapViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit
import MapKit

class DriversMapViewController: UIViewController, DriversMapViewProtocol {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Dependencies
    
    var interactor: DriversMapViewToInteractorProtocol?
    
    // MARK: - Properties
    
    var currentMapFrameCoordinates: MapFrameCoordinates {
        let topLeftCoordinatePoint = mapView.convert(CGPoint(x: 0, y: 0), toCoordinateFrom: mapView)
        let bottomRightCoordinatePoint = mapView.convert(CGPoint(x: mapView.bounds.width, y: mapView.bounds.height), toCoordinateFrom: mapView)
        return MapFrameCoordinates(topLeftPointLat: topLeftCoordinatePoint.latitude,
                                   topleftPointLong: topLeftCoordinatePoint.longitude,
                                   BottomRightPointLat: bottomRightCoordinatePoint.latitude,
                                   BottomRightPointLong: bottomRightCoordinatePoint.longitude)
    }
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.viewStarted(with: currentMapFrameCoordinates)
    }
}

extension DriversMapViewController {
    
}
