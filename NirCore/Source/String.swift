//
//  String.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import Foundation

extension String {
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

public func toURL(_ string: String) -> URL? {
    return URL(string: string)
}
