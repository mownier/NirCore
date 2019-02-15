//
//  Operator.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

precedencegroup Group {
    associativity: left
}
infix operator >>>: Group

public func >>> <A, B, C>(_ lhs: @escaping (A) -> B,
                          _ rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}
