//
//  ActionsDrawerViewController.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

public protocol ActionsDrawerViewControllerDelegate: class {
    func didSelectAction(_ action: Action)
}

public class ActionsDrawerViewController: UIViewController {
    public weak var delegate: ActionsDrawerViewControllerDelegate?

    public let interactor = ActionsDrawerInteractor()
    var mainView: ActionsDrawerView {
        return view as! ActionsDrawerView
    }

    private let actionGroups: [ActionGroup]
    private let actionableItem: ActionableItem

    public init(actionableItem: ActionableItem, actionGroups: [ActionGroup]) {
        self.actionGroups = actionGroups
        self.actionableItem = actionableItem
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .custom
        modalPresentationCapturesStatusBarAppearance = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        let drawerView = ActionsDrawerView(actionableItem: actionableItem, actionGroups: actionGroups)
        drawerView.delegate = self
        self.view = drawerView
    }
}

extension ActionsDrawerViewController: ActionsDrawerViewDelegate {
    func didSelectAction(_ action: Action) {
        dismiss(animated: true, completion: {
            self.delegate?.didSelectAction(action)
        })
    }

    func didPan(_ progress: CGFloat, state: UIGestureRecognizer.State) {
        ActionsDrawerHelper.mapGestureStateToInteractor(gestureState: state, progress: progress, interactor: interactor, presenting: false) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ActionsDrawerViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ActionsDrawerAnimationController(style: .present)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ActionsDrawerAnimationController(style: .dismiss)
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }


    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ActionsDrawerPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
