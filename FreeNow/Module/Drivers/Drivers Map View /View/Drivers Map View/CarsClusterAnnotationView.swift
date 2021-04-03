//
//  CarsClusterAnnotationView.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/2/21.
//

import Foundation
import MapKit

class CarsClusterAnnotationView: MKAnnotationView {

    // MARK: - Initializers
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        updateImage()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Inherted Properties
    
    override var annotation: MKAnnotation? { didSet { updateImage() } }

    // MARK: - Private Functions
    
    private func updateImage() {
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            self.image = annotatinoImage(with: clusterAnnotation.memberAnnotations.count)
        } else {
            self.image = annotatinoImage(with: 1)
        }
    }

    private func annotatinoImage(with count: Int) -> UIImage {
        let bounds = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))

        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { _ in
            // Fill full circle with tricycle color
            AppTheme.Colors.primary.setFill()
            UIBezierPath(ovalIn: bounds).fill()

            // Fill inner circle with white color
            UIColor.white.setFill()
            UIBezierPath(ovalIn: bounds.insetBy(dx: 4, dy: 4)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: AppTheme.Colors.secondary,
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]

            let text = count > 99 ? "+99" : "\(count)"
            let size = text.size(withAttributes: attributes)
            let origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.midY - size.height / 2)
            let rect = CGRect(origin: origin, size: size)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
