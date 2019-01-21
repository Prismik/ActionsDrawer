//
//  ViewController.swift
//  ActionsDrawer
//
//  Created by Francis on 01/21/2019.
//  Copyright (c) 2019 Francis. All rights reserved.
//

import UIKit
import ActionsDrawer

class ViewController: UIViewController {
    private var mainView: ExampleView {
        return view as! ExampleView
    }

    private var drawerController: UIViewController?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let example = ExampleView()
        example.delegate = self
        self.view = example
    }
}

extension ViewController: ActionsDrawerViewControllerDelegate {
    func didSelectAction(_ action: Action) {
        action.handler()
    }
}

extension ViewController: ExampleViewDelegate {
    func presentDrawer() {
        let pizza = Pizza(radius: 12, toppings: ["Pepperonni", "Cheese"])
        let drawerViewController = ActionsDrawerViewController(actionableItem: pizza, actionGroups: [
            ActionGroup(actions: [
                Action(icon: UIImage(named: "oven"), title: "Bake", tintColor: .blue, handler: {
                    print("Baking the pizza")
                }),
                Action(icon: UIImage(named: "pizzaCar"), title: "Deliver", tintColor: .blue, handler: {
                    print("Delivering the pizza")
                })
            ]),
            ActionGroup(actions: [
                Action(icon: UIImage(named: "garbage"), title: "Garbage", tintColor: .red, handler: {
                    print("Pizza tastes bad. Putting in the garbage")
                })
            ])
        ])
        self.drawerController = drawerViewController
        drawerViewController.delegate = self
        drawerViewController.transitioningDelegate = drawerViewController
        present(drawerViewController, animated: true, completion: nil)
    }
}
