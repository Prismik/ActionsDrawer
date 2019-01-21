//
//  ActionsDrawerHelper.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class ActionsDrawerHelper {
    static let percentThreshold: CGFloat = 0.4

    static func progress(translationInView: CGPoint, viewBounds: CGRect) -> CGFloat {
        let pointOnAxis: CGFloat = translationInView.y
        let axisLength: CGFloat = viewBounds.height
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis: Float = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent: Float = fminf(positiveMovementOnAxis, 1.0)
        return CGFloat(positiveMovementOnAxisPercent)
    }
    
    static func mapGestureStateToInteractor(gestureState: UIGestureRecognizer.State, progress: CGFloat, interactor: ActionsDrawerInteractor?, presenting: Bool, didStartHandler: () -> Void) {
        guard let interactor = interactor else { return }
        interactor.completionSpeed = 1

        switch gestureState {
        case .began:
            interactor.hasStarted = true
            didStartHandler()
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            if interactor.shouldFinish {
                interactor.finish()
            } else {
                interactor.completionSpeed = (1 - progress)
                interactor.cancel()
            }
        default:
            break
        }
    }
}
