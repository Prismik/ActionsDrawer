//
//  ActionsDrawerPresentationController.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class ActionsDrawerPresentationController: UIPresentationController {
    private let backgroundView = UIView()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackground)))
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.alpha = 0
    }

    override func presentationTransitionWillBegin() {
        guard let containerView =  containerView else { return }

        containerView.insertSubview(backgroundView, at: 0)

        presentedView?.frame = CGRect(x: 0, y: containerView.frame.height,
                                      width: containerView.frame.width, height: containerView.frame.height * 0.45)
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.alpha = 1
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 1
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.backgroundView.alpha = 0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 0
        })
    }

    override func containerViewDidLayoutSubviews() {
        guard let containerView = containerView else { return }

        backgroundView.frame = containerView.frame
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let containerView =  containerView else { return }
        presentedView?.frame = CGRect(x: 0, y: containerView.frame.height,
                                      width: containerView.frame.width, height: containerView.frame.height * 0.45)
    }

    @objc private func didTapBackground() {
        guard let actionsDrawerViewController = presentedViewController as? ActionsDrawerViewController else { return }
        actionsDrawerViewController.interactor.tapDismiss = true
        actionsDrawerViewController.dismiss(animated: true, completion: nil)
    }
}
