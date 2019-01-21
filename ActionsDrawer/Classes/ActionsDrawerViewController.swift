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
    private enum HeaderType {
        case title(value: String)
        case actionableItem(value: ActionableItem)
    }

    public weak var delegate: ActionsDrawerViewControllerDelegate?

    public let interactor = ActionsDrawerInteractor()
    var mainView: ActionsDrawerView {
        return view as! ActionsDrawerView
    }

    private let actionGroups: [ActionGroup]
    private let headerType: HeaderType

    public convenience init(title: String, actionGroups: [ActionGroup]) {
        self.init(headerType: HeaderType.title(value: title), actionGroups: actionGroups)
    }

    public convenience init(actionableItem: ActionableItem, actionGroups: [ActionGroup]) {
        self.init(headerType: HeaderType.actionableItem(value: actionableItem), actionGroups: actionGroups)
    }

    private init(headerType: HeaderType, actionGroups: [ActionGroup]) {
        self.headerType = headerType
        self.actionGroups = actionGroups
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .custom
        modalPresentationCapturesStatusBarAppearance = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        let drawerView: ActionsDrawerView
        switch headerType {
        case .title(let value):
            drawerView = ActionsDrawerView(title: value, actionGroups: actionGroups)
        case .actionableItem(let value):
            drawerView = ActionsDrawerView(actionableItem: value, actionGroups: actionGroups)
        }
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
