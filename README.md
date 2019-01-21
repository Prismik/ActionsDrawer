# ActionsDrawer

[![CI Status](https://img.shields.io/travis/Francis/ActionsDrawer.svg?style=flat)](https://travis-ci.org/Francis/ActionsDrawer)
[![Version](https://img.shields.io/cocoapods/v/ActionsDrawer.svg?style=flat)](https://cocoapods.org/pods/ActionsDrawer)
[![License](https://img.shields.io/cocoapods/l/ActionsDrawer.svg?style=flat)](https://cocoapods.org/pods/ActionsDrawer)
[![Platform](https://img.shields.io/cocoapods/p/ActionsDrawer.svg?style=flat)](https://cocoapods.org/pods/ActionsDrawer)

## How to use

```swift
// Using the hardcoded title approach

func present() {
    let drawerViewController = ActionsDrawerViewController(title: "Title provided as a string", actionGroups: [
        ActionGroup(actions: [
            Action(icon: nil, title: "Do the thing", tintColor: .blue, handler: {
                print("Did the thing")
            }),
            Action(icon: nil, title: "Do the other thing", tintColor: .blue, handler: {
                print("Did the other thing")
            })
        ]),
        ActionGroup(actions: [
            Action(icon: nil, title: "Do the dangerous thing thing", tintColor: .red, handler: {
                print("Did the dangerous thing")
            })
        ])
    ])
    self.drawerController = drawerViewController
    drawerViewController.delegate = self
    drawerViewController.transitioningDelegate = drawerViewController
    present(drawerViewController, animated: true, completion: nil)
}

// Using the protocol approach

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

// ...

func present() {
    let pizza = Pizza(radius: 12, toppings: ["Pepperonni", "Cheese"])

    let viewController = ActionsDrawerViewController(actionableItem: pizza, actionGroups: [
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
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ActionsDrawer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ActionsDrawer'
```

## Author

Francis, francis.beauchamp@finecraftedapps.com

## License

ActionsDrawer is available under the MIT license. See the LICENSE file for more info.
