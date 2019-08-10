//
//  FileRepresentable.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

protocol FileRepresentable: Codable {
    static var fileName: String { get }
}
