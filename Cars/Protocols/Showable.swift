//
//  Showable.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

protocol Showable {
    var name: String { get }
    var number: String { get }
    var imageName: String { get }
    var price: String { get }

    var priceIsShown: Bool { get set }
}
