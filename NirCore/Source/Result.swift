//
//  Result.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import Foundation

public enum Result<T> {

    case okay(T)
    case notOkay(Error)
    
    public var value: T? {
        switch self {
        case let .okay(value): return value
        default: return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case let .notOkay(error): return error
        default: return nil
        }
    }
    
    public var isOkay: Bool {
        switch self {
        case .okay: return true
        default: return false
        }
    }
    
    public var isNotOkay: Bool {
        return !isOkay
    }
}
