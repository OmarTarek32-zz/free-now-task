//
//  CarAnnotationView.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/2/21.
//

import UIKit
import MapKit

class CarAnnotationView: MKAnnotationView, Reuseable {

    private var driverImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "car"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
    
    func configure(angle: CGFloat) {
        self.transform = .identity
        self.transform = CGAffineTransform(rotationAngle: CGFloat(deg2rad(Double(angle))))
    }
    
    private func deg2rad(_ number: Double) -> Double {
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
