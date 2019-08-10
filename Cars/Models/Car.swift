//
//  Car.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

struct Car: FileRepresentable {
    static private(set) var fileName: String = "Cars"

    let id: UInt
    let model: String
    let immatriculation: String

    enum CodingKeys: String, CodingKey {
        case id
        case model = "Model"
        case immatriculation = "Immatriculation"
    }

    let imageName = "icon"
}
