//
//  ActionsDrawerHeaderView.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class ActionsDrawerHeaderView: UIView {
    private var handleView = UIView()
    private var itemView: UIView
    private var separatorView = UIView()

    convenience init(title: String) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        self.init(titleView: label)
    }

    convenience init(actionableItem: ActionableItem) {
        self.init(titleView: actionableItem.drawerView)
    }

    private init(titleView: UIView) {
        self.itemView = titleView
        super.init(frame: .zero)

        handleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        handleView.layer.cornerRadius = 2
        addSubview(handleView)

        addSubview(itemView)

        separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        addSubview(separatorView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 80)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let margin: CGFloat = 10
        let sideMargin: CGFloat = 20

        handleView.pin.top(margin).size(CGSize(width: 45, height: 4)).hCenter()
        separatorView.pin.bottom().horizontally().height(1)
        itemView.pin.below(of: handleView).horizontally(sideMargin).above(of: separatorView).marginVertical(margin)
    }
}
