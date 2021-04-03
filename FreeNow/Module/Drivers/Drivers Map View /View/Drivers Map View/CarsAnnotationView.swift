//
//  CarAnnotationView.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/2/21.
//

import UIKit
import MapKit

class CarsAnnotationView: MKAnnotationView, Reuseable {

    // MARK: - UI Elements
    private var driverImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "car"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = CarsAnnotationView.reuseIdentifier
        collisionMode = .circle
        canShowCallout = true
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Inherted Properties

    override var annotation: MKAnnotation? {
        didSet {
            clusteringIdentifier = CarsAnnotationView.reuseIdentifier
            if let mark = annotation as? CarsAnnotationViewModel {
                rotate(angle: mark.getHeading())
            }
        }
    }
    
    /// Make the annotation looks selected by scalling it by twoic of its size
    func markSelected() {
        let rotation = degreeToRadian((annotation as? CarsAnnotationViewModel)?.getHeading() ?? 0)
        transform = CGAffineTransform(scaleX: 2, y: 2).rotated(by: rotation)
    }
    
    /// Make the annotation looks unselected by putting its original size
    func markUnSelected() {
        let rotation = degreeToRadian((annotation as? CarsAnnotationViewModel)?.getHeading() ?? 0)
        transform = CGAffineTransform(rotationAngle: rotation)
    }
    
    // MARK: - Private Functions
    
    private func rotate(angle: CGFloat) {
        self.transform = .identity
        self.transform = CGAffineTransform(rotationAngle: CGFloat(degreeToRadian(angle)))
    }
    
    private func degreeToRadian(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    private func setupSubviews() {
        addSubview(driverImageView)
        translatesAutoresizingMaskIntoConstraints = false
        driverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        driverImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        driverImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        driverImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        driverImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        driverImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        driverImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

    }
}
