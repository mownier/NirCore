//
//  CollectionTests.swift
//  NirCoreTests
//
//  Created by Mounir Ybanez on 2/15/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import XCTest
import NirCore

class CollectionTests: XCTestCase {
    
    func testDictionaryHasKeyAndHasNoKey() {
        let dictionary = ["id": 1]
        XCTAssertTrue(dictionary.hasKey("id"))
        XCTAssertFalse(dictionary.hasNoKey("id"))
        XCTAssertTrue(dictionary.hasNoKey("count"))
        XCTAssertFalse(dictionary.hasKey("count"))
    }
    
    func testDictionaryStringAndStringOrNilForKeyAndDefault() {
        let dictionary: [AnyHashable: Any] = ["id": 1, "name": "Foo"]
        var string = dictionary.string(for: "id")
        XCTAssertTrue(string.isEmpty)
        string = dictionary.string(for: "count")
        XCTAssertTrue(string.isEmpty)
        string = dictionary.string(for: "id", default: "defaultID")
        XCTAssertEqual("defaultID", string)
        string = dictionary.string(for: "name")
        XCTAssertEqual("Foo", string)
        string = dictionary.string(for: "name", default: "Bar")
        XCTAssertEqual("Foo", string)
        
        var optionalString = dictionary.stringOrNil(for: "id")
        XCTAssertNil(optionalString)
        optionalString = dictionary.stringOrNil(for: "count")
        XCTAssertNil(optionalString)
        optionalString = dictionary.stringOrNil(for: "id", default: "defaultID")
        XCTAssertNotNil(optionalString)
        XCTAssertEqual("defaultID", optionalString)
        optionalString = dictionary.stringOrNil(for: "name")
        XCTAssertNotNil(optionalString)
        XCTAssertEqual("Foo", optionalString)
        optionalString = dictionary.stringOrNil(for: "name", default: "Bar")
        XCTAssertNotNil(optionalString)
        XCTAssertEqual("Foo", optionalString)
    }
    
    func testArrayForEachElement() {
        let exp = expectation(description: "testArrayForEachElement")
        let array: [Int] = [1, 2, 3, 4, 5]
        let transform: (Int, @escaping (String?) -> Void) -> Void = { int, completion in
            let plusInterval: Double = int == 1 ? 2 : 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + plusInterval, execute: {
                if int == 5 || int == 3 {
                    completion(nil)
                } else {
                    completion(String(describing: int))
                }
            })
        }
        array.forEachElement(transform: transform) { newItems in
            XCTAssertEqual(["1", "2", "4"], newItems)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10.0)
    }
    
    func testDictionaryValueAndValueOrNil() {
        let dictionary = ["1": 1]
        let string: String = dictionary.value(for: "1", default: "defaultString")
        XCTAssertEqual("defaultString", string)
        let int: Int = dictionary.value(for: "1", default: 9000)
        XCTAssertEqual(1, int)
        var optionalString: String? = dictionary.valueOrNil(for: "1")
        XCTAssertNil(optionalString)
        optionalString = dictionary.valueOrNil(for: "1", default: "defaultString")
        XCTAssertEqual("defaultString", optionalString)
        var optionalInt: Int? = dictionary.valueOrNil(for: "2")
        XCTAssertNil(optionalInt)
        optionalInt = dictionary.valueOrNil(for: "2", default: 9000)
        XCTAssertNotNil(optionalInt)
        XCTAssertEqual(9000, optionalInt)
        optionalInt = dictionary.valueOrNil(for: "1")
        XCTAssertNotNil(optionalInt)
        XCTAssertEqual(1, optionalInt)
    }
}
