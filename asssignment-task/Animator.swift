//
//  Animator.swift
//  asssignment-task
//
//  Created by Rutwik Shinde on 05/02/22.
//

import UIKit

// class to implement animation for the detailVC presentation
class Animator: NSObject {
    
    private let animationDuration: Double
    
    init(animationDuration: Double){
        self.animationDuration = animationDuration
    }
}

extension Animator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        transitionContext.containerView.addSubview(toVC.view)
        presentAnimation(with: transitionContext, viewToAnimate: toVC.view)
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.6)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
