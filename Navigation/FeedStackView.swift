//
//  FeedStackView.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 18.03.2022.
//

import UIKit

class FeedStackView: UIStackView {

    func attributesStackView () {
        self.axis = .vertical
        self.spacing = 10.0
        self.alignment = .fill
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
