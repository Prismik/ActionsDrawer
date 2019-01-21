//
//  Pizza.swift
//  ActionsDrawer_Example
//
//  Created by Francis Beauchamp on 2019-01-21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ActionsDrawer

struct Pizza {
    let radius: Int
    let toppings: [String]
}

extension Pizza: ActionableItem {
    var drawerView: UIView {
        let view = UILabel()
        view.text = "\(radius) inch pizza - \(toppings.count) toppings"
        view.textColor  = UIColor.orange
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }
}
