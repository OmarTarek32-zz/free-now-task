//
//  CircularAnimationController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation
import UIKit

class CircularAnimationController: NSObject {
    
    // MARK: - Nested Type
    
    enum CircularTransitionMode:Int {
        case present, dismiss
    }
    
    // MARK: - Public Properties
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    var transitionMode:CircularTransitionMode = .present
    var circleColor = UIColor.white
    
    // MARK: - Private Properties
    
    private var circle = UIView()
    private var duration = 0.4
}

extension CircularAnimationController:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                presentedView.frame = containerView.frame
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModeCubic]) {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                        self.circle.transform = CGAffineTransform.identity
                        presentedView.transform = CGAffineTransform.identity
                    }
                    
                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                        presentedView.alpha = 1
                    }
                } completion: { success in
                    transitionContext.completeTransition(success)
                }
            }
        } else {
           
            if let returningView = transitionContext.view(forKey: .from) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0

                }, completion: { (success: Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                    
                })
            }
        }
    }
    
    func frameForCircle (withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = viewSize.width
        let yLength = viewSize.height
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}
