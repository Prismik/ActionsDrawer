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
    func presentDrawerUsingProtocol()
}

class ExampleView: UIView {
    weak var delegate: ExampleViewDelegate?

    private let showDrawerButton = UIButton()
    private let showTitleDrawerButton = UIButton()

    init() {
        super.init(frame: .zero)

        showDrawerButton.setTitleColor(.blue, for: .normal)
        showDrawerButton.setTitle("Actionable", for: .normal)
        showDrawerButton.addTarget(self, action: #selector(presentDrawer), for: .touchUpInside)
        addSubview(showDrawerButton)

        showTitleDrawerButton.setTitleColor(.blue, for: .normal)
        showTitleDrawerButton.setTitle("Title", for: .normal)
        showTitleDrawerButton.addTarget(self, action: #selector(presentTitleDrawer), for: .touchUpInside)
        addSubview(showTitleDrawerButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        showDrawerButton.frame = CGRect(x: 0, y: (frame.height - 50) / 2, width: frame.width, height: 50)

        showTitleDrawerButton.frame = CGRect(x: 0, y: showDrawerButton.frame.maxY + 20, width: frame.width, height: 50)
    }

    @objc private func presentDrawer() {
        delegate?.presentDrawer()
    }

    @objc private func presentTitleDrawer() {
        delegate?.presentDrawerUsingProtocol()
    }
}
