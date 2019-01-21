//
//  ActionsDrawerAnimationController.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class ActionsDrawerAnimationController: NSObject {
    private let style: PresentationStyle

    enum PresentationStyle {
        case present
        case dismiss
    }

    init(style: PresentationStyle) {
        self.style = style
    }

}

extension ActionsDrawerAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let transitionContext = transitionContext, style == .dismiss, transitionContext.isInteractive else { return 0.2 }
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }

        switch style {
        case .present:
            present(from: fromViewController, to: toViewController, using: transitionContext)
        case .dismiss:
            dismiss(from: fromViewController, to: toViewController, using: transitionContext)
        }
    }

    private func present(from fromViewController: UIViewController, to toViewController: UIViewController, using transitionContext: UIViewControllerContextTransitioning) {
        guard let drawer = toViewController.view else { return }
        transitionContext.containerView.insertSubview(drawer, aboveSubview: fromViewController.view)

        drawer.frame = CGRect(x: 0, y: transitionContext.containerView.frame.height, width: drawer.frame.width, height: drawer.frame.height)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            drawer.frame = CGRect(x: 0, y: transitionContext.containerView.frame.height - drawer.frame.height, width: drawer.frame.width, height: drawer.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func dismiss(from fromViewController: UIViewController, to toViewController: UIViewController, using transitionContext: UIViewControllerContextTransitioning) {
        guard let drawer = fromViewController.view else { return }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            drawer.frame = CGRect(x: 0, y: transitionContext.containerView.frame.height, width: drawer.frame.width, height: drawer.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
