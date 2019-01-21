//
//  ActionsDrawerView.swift
//  MyVoice
//
//  Created by Francis Beauchamp on 2018-11-06.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit
import PinLayout

public protocol ActionableItem {
    var drawerView: UIView { get }
}

protocol ActionsDrawerViewDelegate: class {
    func didSelectAction(_ action: Action)
    func didPan(_ progress: CGFloat, state: UIGestureRecognizer.State)
}

class ActionsDrawerView: UIView {
    private enum ActionsDrawerItem {
        case groupHeader
        case action(action: Action)
    }

    weak var delegate: ActionsDrawerViewDelegate?

    private static let actionCellReuseIdentifier = "ActionCellReuseIdentifier"

    private let shapeLayer = CAShapeLayer()
    private var headerView: ActionsDrawerHeaderView
    private var tableView = UITableView()

    private var items: [ActionsDrawerItem] = []

    private let headerHeight: CGFloat = 30
    private let actionHeight: CGFloat = 60

    init(actionableItem: ActionableItem, actionGroups: [ActionGroup]) {
        headerView = ActionsDrawerHeaderView(actionableItem: actionableItem)
        super.init(frame: .zero)
        items = mapActionGroups(actionGroups)

        addSubview(headerView)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        panGesture.cancelsTouchesInView = false
        headerView.addGestureRecognizer(panGesture)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(ActionGroupCell.self, forCellReuseIdentifier: ActionGroupCell.reuseIdentifier)
        tableView.register(ActionCell.self, forCellReuseIdentifier: ActionCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        addSubview(tableView)

        backgroundColor = .white
        layer.mask = shapeLayer
        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let headerViewSize = headerView.sizeThatFits(frame.size)
        headerView.pin.topLeft().size(headerViewSize)
        tableView.pin.below(of: headerView).horizontally().bottom()
        shapeLayer.pin.all()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
    }

    @objc private func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let progress = ActionsDrawerHelper.progress(translationInView: translation, viewBounds: bounds )

        delegate?.didPan(progress, state: sender.state)
    }

    private func mapActionGroups(_ groups: [ActionGroup]) -> [ActionsDrawerItem] {
        var items: [ActionsDrawerItem] = []
        for group in groups {
            items.append(.groupHeader)
            for action in group.actions {
                items.append(.action(action: action))
            }
        }

        items.append(.groupHeader)

        return items
    }
}

extension ActionsDrawerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case .groupHeader:
            break
        case .action(let action):
            delegate?.didSelectAction(action)
        }
    }
}

extension ActionsDrawerView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .groupHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionGroupCell.reuseIdentifier) as! ActionGroupCell
            cell.isSeparatorVisible = indexPath.row != 0 && indexPath.row != items.count - 1
            return cell
        case .action(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionCell.reuseIdentifier) as! ActionCell
            cell.configure(action: action)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch items[indexPath.row] {
        case .groupHeader:
            return indexPath.row == 0 || indexPath.row == items.count - 1 ? headerHeight / 2 : headerHeight
        case .action:
            return actionHeight
        }
    }
}
