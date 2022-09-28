//
//  DecimalUtil.swift
//  Bankey
//
//  Created by RuslanS on 9/21/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
