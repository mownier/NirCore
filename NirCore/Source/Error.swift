//
//  Error.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import Foundation

public struct NetworkingError: Error, CustomStringConvertible {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var description: String {
        return message
    }
    
    public var localizedDescription: String {
        return message
    }
}

public func networkingError(_ message: String) -> NetworkingError {
    return NetworkingError(message: message)
}

public func nsError(domain: String = "", code: Int = 0, info: [String: String]?) -> NSError {
    return NSError(domain: domain, code: code, userInfo: info)
}

public func nsError(domain: String = "", code: Int = 0, message: String) -> NSError {
    return nsError(domain: domain, code: code, info: [NSLocalizedDescriptionKey: message])
}
