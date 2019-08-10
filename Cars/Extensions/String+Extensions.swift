//
//  String+Extensions.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

extension String {
    func decimalPrice() -> Decimal {
        let formatter = NumberFormatter()

        formatter.groupingSeparator = "."
        if let price = self.components(separatedBy: " Euro").first,
            let number = formatter.number(from: price) {
            return number.decimalValue
        }

        return 0.0
    }
}
