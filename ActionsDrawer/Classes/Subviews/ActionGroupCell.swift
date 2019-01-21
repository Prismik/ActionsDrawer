//
//  ActionGroupCell.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-08.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

public class ActionGroupCell: UITableViewCell {
    static let reuseIdentifier = "ActionGroupCellReuseIdentifier"

    var isSeparatorVisible: Bool = true {
        didSet {
            separator.isHidden = !isSeparatorVisible
        }
    }

    private let separator = UIView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        separator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        addSubview(separator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        separator.pin.vCenter().horizontally().height(1)
    }
}
