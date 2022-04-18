//
//  Protocol.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 01.04.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
