//
//  Ethnicity.swift
//  Lodestar
//
//  Created by Bailey on 11/24/21.
//

import Foundation

struct Ethnicity {
    enum EthnicityType: String, CaseIterable {
        case asian = "asian"
        case black = "black"
        case latino = "latino"
        case white = "white"
        case middleEastern = "middle_eastern"
        case multiRacial = "multi_racial"
        case nativeAmerican = "native_american"

        var formatted: String {
            switch self {
            case .asian:
                return "Asian"
            case .black:
                return "Black"
            case .latino:
                return "Hispanic/Latino"
            case .white:
                return "White"
            case .middleEastern:
                return "Middle Eastern"
            case .multiRacial:
                return "Multi-Racial"
            case .nativeAmerican:
                return "Native American"
            }
        }
    }
    
    static func rangeOfValues() -> [String] {
        EthnicityType.allCases.map { kind in
            kind.formatted
        }
    }
    
    var selectedIndex: Int?
    var selectedValue: EthnicityType? {
        set {
            if let value = newValue {
                selectedIndex = EthnicityType.allCases.firstIndex(of: value)
            }
        }
        
        get {
            if let index = selectedIndex {
                return EthnicityType.allCases[index]
            }
            
            return nil
        }
    }
    
    init () {
        
    }
    
    init(value: String) {
        selectedValue = EthnicityType(rawValue: value)
    }

    var formatted: String {
        if let selectedIndex = selectedIndex {
            let kind = EthnicityType.allCases[selectedIndex]
            return kind.formatted
        }
        
        return ""
    }
    
    var raw: Any? {
        if let selectedIndex = selectedIndex {
            return EthnicityType.allCases[selectedIndex]
        }
        
        return nil
    }
}
