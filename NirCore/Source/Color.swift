//
//  Color.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import UIKit

public func color(from hex: String) -> UIColor? {
    let string = hex
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt32 = 0
    
    guard Scanner(string: string).scanHexInt32(&rgb) else {
        return nil
    }
    
    switch string.count {
    case 6:
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    
    case 8:
        let r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        let a = CGFloat(rgb & 0x000000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    
    default:
        return nil
    }
}
