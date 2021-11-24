//
//  Gender.swift
//  Lodestar
//
//  Created by Bailey on 11/24/21.
//

import Foundation

struct Gender {
    enum GenderType: String, CaseIterable {
        case male
        case female

        var formatted: String {
            switch self {
            case .male:
                return "Male"
            case .female:
                return "Female"
            }
        }
    }
    
    static func rangeOfValues() -> [String] {
        GenderType.allCases.map { kind in
            kind.formatted
        }
    }

    
    var selectedIndex: Int?
    var selectedValue: GenderType? {
        set {
            if let value = newValue {
                selectedIndex = GenderType.allCases.firstIndex(of: value)
            }
        }
        
        get {
            if let index = selectedIndex {
                return GenderType.allCases[index]
            }
            
            return nil
        }
    }
    
    init () {
        
    }
    
    init(value: String) {
        selectedValue = GenderType(rawValue: value)
    }

    var formatted: String {
        if let selectedIndex = selectedIndex {
            let kind = GenderType.allCases[selectedIndex]
            return kind.formatted
        }
        
        return ""
    }
    
    var raw: Any? {
        if let selectedIndex = selectedIndex {
            return GenderType.allCases[selectedIndex]
        }
        
        return nil
    }}
