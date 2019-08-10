//
//  Price.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation
struct Price: FileRepresentable {
    static private(set) var fileName: String = "Prices"

    let id: Int
    let price: String

    enum CodingKeys: String, CodingKey {
        case id
        case price = "Price"
    }
}
