//
//  ExampleView.swift
//  ActionsDrawer_Example
//
//  Created by Francis Beauchamp on 2019-01-21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ActionsDrawer

protocol ExampleViewDelegate: class {
    func presentDrawer()
}

class ExampleView: UIView {
    weak var delegate: ExampleViewDelegate?

    private let showDrawerButton = UIButton()

    init() {
        super.init(frame: .zero)

        showDrawerButton.setTitleColor(.blue, for: .normal)
        showDrawerButton.setTitle("Show drawer", for: .normal)
        showDrawerButton.addTarget(self, action: #selector(presentDrawer), for: .touchUpInside)
        addSubview(showDrawerButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        showDrawerButton.frame = CGRect(x: 0, y: (frame.height - 50) / 2, width: frame.width, height: 50)
    }

    @objc private func presentDrawer() {
        delegate?.presentDrawer()
    }
}
