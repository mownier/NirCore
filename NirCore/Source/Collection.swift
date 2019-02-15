//
//  Collection.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import Foundation

extension Collection {
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension ArraySlice {
    
    public func toArray() -> Array<Element> {
        return Array(self)
    }
}

extension Dictionary {
    
    public func hasKey(_ key: Key) -> Bool {
        return self[key] != nil
    }
    
    public func hasNoKey(_ key: Key) -> Bool {
        return !hasKey(key)
    }
    
    public func valueOrNil<T>(for key: Key, default: T? = nil) -> T? {
        return self[key] as? T ?? `default`
    }
    
    public func value<T>(for key: Key, default: T) -> T {
        return self[key] as? T ?? `default`
    }
}

extension Dictionary where Value == Any {
    
    public func stringOrNil(for key: Key, default: String? = nil) -> String? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func intOrNil(for key: Key, default: Int? = nil) -> Int? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func doubleOrNil(for key: Key, default: Double? = nil) -> Double? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func boolOrNil(for key: Key, default: Bool? = nil) -> Bool? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func dictionaryOrNil<K,V>(for key: Key, default: Dictionary<K,V>? = nil) -> Dictionary<K,V>? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func arrayOrNil<E>(for key: Key, default: Array<E>? = nil) -> Array<E>? {
        return valueOrNil(for: key, default: `default`)
    }
    
    public func string(for key: Key, default: String = "") -> String {
        return value(for: key, default: `default`)
    }
    
    public func double(for key: Key, default: Double = 0.0) -> Double {
        return value(for: key, default: `default`)
    }
    
    public func int(for key: Key, default: Int = 0) -> Int {
        return value(for: key, default: `default`)
    }
    
    public func bool(for key: Key, default: Bool = false) -> Bool {
        return value(for: key, default: `default`)
    }
    
    public func dictionary<K,V>(for key: Key, default: Dictionary<K,V> = [:]) -> Dictionary<K,V> {
        return value(for: key, default: `default`)
    }
    
    public func array<E>(for key: Key, default: Array<E> = []) -> Array<E> {
        return value(for: key, default: `default`)
    }
    
    public func urlValue(for key: Key) -> URL? {
        return URL(string: string(for: key))
    }
}

extension Array {
    
    public func forEachElement<T>(
        transform: @escaping (Element, @escaping (T?) -> Void) -> Void,
        completion: @escaping ([T]) -> Void) {
        let size = count
        var index = 0
        var items: [(Int, T)] = []
        enumerated().forEach { e in
            transform(e.element) { item in
                if item != nil {
                    items.append((e.offset, item!))
                }
                index += 1
                if index >= size {
                    completion(items.sorted(by: { $0.0 < $1.0 }).map({ $0.1 }))
                }
            }
        }
    }
}
