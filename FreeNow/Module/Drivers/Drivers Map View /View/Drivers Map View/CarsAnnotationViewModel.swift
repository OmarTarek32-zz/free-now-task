//
//  CarsAnnotationViewModel.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/3/21.
//

import Foundation
import MapKit

class CarsAnnotationViewModel: NSObject, MKAnnotation {
    
    // MARK: - Dependencies
    
    var coordinate: CLLocationCoordinate2D
    
    // MARK: - Private Properties
    
    private var heading: CGFloat?
    
    // MARK: - Initializers
    
    init(coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
        super.init()
    }
    
    // MARK: - Public Functions
    
    func setHeading(_ value: CGFloat) {
        heading = value
    }
    
    func getHeading() -> CGFloat {
        return heading ?? 0
    }
}
