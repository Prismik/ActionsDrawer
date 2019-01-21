//
//  ActionGroup.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

public struct ActionGroup {
    public let actions: [Action]

    public init(actions: [Action]) {
        self.actions = actions
    }
}

public struct Action {
    public let icon: UIImage?
    public let title: String
    public let tintColor: UIColor
    public let handler: () -> Void

    public init(icon: UIImage?, title: String, tintColor: UIColor, handler: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.tintColor = tintColor
        self.handler = handler
    }
}
