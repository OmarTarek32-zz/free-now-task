//
//  DriversMapView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit
import MapKit

class DriversMapView: MKMapView {
    
    // MARK: - Properties
    
     var currentMapFrameCoordinates: MapFrameCoordinate {
        let topLeftCoordinatePoint = convert(CGPoint(x: 0, y: 0), toCoordinateFrom: self)
        let bottomRightCoordinatePoint = convert(CGPoint(x: bounds.width, y: bounds.height), toCoordinateFrom: self)
        return MapFrameCoordinate(topLeftPointLat: topLeftCoordinatePoint.latitude,
                                   topleftPointLong: topLeftCoordinatePoint.longitude,
                                   BottomRightPointLat: bottomRightCoordinatePoint.latitude,
                                   BottomRightPointLong: bottomRightCoordinatePoint.longitude)
    }
    
    // MARK: - Public Functions
    
    func displayArea(in frame: MapFrameCoordinate) {
        
        let rect = mapRect(from: frame)
        setVisibleMapRect(rect, animated: true)
    }
    
    func addDrivers(_ drivers: [DriverViewModel]) {
        addAnnotations(drivers.map {
            let annotation = MKPointAnnotation()
            annotation.coordinate = $0.coordinate
            return annotation
        })
    }
    
    // MARK: - Private Functions
    
    private func mapRect(from frame: MapFrameCoordinate) -> MKMapRect {
        let coordinate1 = CLLocationCoordinate2D(latitude: frame.topLeftPointLat,
                                                 longitude: frame.topleftPointLong)
        let coordinate2 = CLLocationCoordinate2D(latitude: frame.BottomRightPointLat,
                                                 longitude: frame.BottomRightPointLong)
        let p1 = MKMapPoint(coordinate2)
        let p2 = MKMapPoint(coordinate1)
        return MKMapRect(x: fmin(p1.x,p2.x), y: fmin(p1.y,p2.y), width: fabs(p1.x-p2.x), height: fabs(p1.y-p2.y))
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}
