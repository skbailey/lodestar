//
//  DateOfBirth.swift
//  Lodestar
//
//  Created by Bailey on 11/24/21.
//

import Foundation

struct DateOfBirth {
    var current: Date
    var dateFormatter = DateFormatter()
    
    init(current: Date) {
        self.current = current
        dateFormatter.dateFormat = "dd MMMM yyyy"
    }
    
    var formatted: String {
        let selectedDate = dateFormatter.string(from: current)
        return selectedDate
    }
    
    var raw: Any? {
        return current
    }
}
