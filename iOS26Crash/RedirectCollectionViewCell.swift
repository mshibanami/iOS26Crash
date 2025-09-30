//
//  RedirectCollectionViewCell.swift
//  RedirectWebForSafari
//
//  Created by Manabu Nakazawa on 12/1/22.
//  Copyright © 2022 Manabu Nakazawa. All rights reserved.
//
import SwiftUI
import UIKit

final class RedirectCollectionViewCell: UICollectionViewListCell {
    let switchControl: UISwitch = {
        let control = UISwitch()
        control.onTintColor = UIColor(resource: .accent)
        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(switchControl)
        NSLayoutConstraint.activate([
            switchControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
