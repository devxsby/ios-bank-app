//
//  Date+.swift
//  Core
//
//  Created by devxsby on 2023/05/29.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

public extension Date {
    func currentTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH시 mm분"
        return dateFormatter.string(from: self)
    }
}
