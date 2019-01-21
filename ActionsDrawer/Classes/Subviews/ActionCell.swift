//
//  ActionCell.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-08.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

public class ActionCell: UITableViewCell {
    static let reuseIdentifier = "ActionCellReuseIdentifier"

    private let iconView = UIImageView()
    private let actionText = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)

        actionText.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(actionText)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(action: Action) {
        iconView.tintColor = action.tintColor
        iconView.image = action.icon?.withRenderingMode(.alwaysTemplate)
        actionText.text = action.title
        actionText.textColor = action.tintColor
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let sideMargin: CGFloat = 20
        let hasImage = iconView.image != nil
        iconView.pin.left(hasImage ? sideMargin : 0).size(hasImage ? 16 : 0).vCenter()
        actionText.pin.right(of: iconView).marginLeft(sideMargin).vertically().right()
    }
}
