//
//  Height.swift
//  Lodestar
//
//  Created by Bailey on 11/24/21.
//

import Foundation

struct Height {
    static let range: [Int] = Array(48...84)
    static let formattedRange: [String] = range.map {
        let feet = $0 / 12
        let inches = $0 % 12
        return "\(String(feet))' \(inches)\""
    }
    
    var selectedIndex: Int?
    var selectedValue: Int? {
        set {
            if let value = newValue {
                selectedIndex = Height.range.firstIndex(of: value)
            }
        }
        
        get {
            if let index = selectedIndex {
                return Height.range[index]
            }
            
            return nil
        }
    }

    var formatted: String {
        if let selectedIndex = selectedIndex {
            let selectedHeight = Height.range[selectedIndex]
            let feet = selectedHeight / 12
            let inches = selectedHeight % 12
            return "\(String(feet))' \(inches)\""
        }
        
        return ""
    }
    
    var raw: Any? {
        if let selectedIndex = selectedIndex {
            return Height.range[selectedIndex]
        }
        
        return nil
    }
    
    init() {
        
    }
    
    init(value: Int?) {
        selectedValue = value
    }

    func rangeOfValues() -> [String] {
        return Height.formattedRange
    }
}
