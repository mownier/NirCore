//
//  Networking.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import Foundation

public protocol Cancelable {
    
    @discardableResult
    func cancel() -> Bool
}

public protocol Resumeable {
    
    @discardableResult
    func resume() -> Bool
}

public protocol Pauseable {
    
    @discardableResult
    func pause() -> Bool
}

public typealias NetworkTask = Cancelable & Resumeable & Pauseable

extension URLSessionDataTask: Cancelable, Resumeable, Pauseable {
    
    @discardableResult
    public func cancel() -> Bool {
        switch state {
        case .completed, .canceling:
            return false
            
        case .suspended, .running:
            let _: Void = cancel()
            return true
        }
    }
    
    @discardableResult
    public func resume() -> Bool {
        switch state {
        case .completed, .canceling, .running:
            return false
        
        case .suspended:
            let _: Void = resume()
            return true
        }
    }
    
    @discardableResult
    public func pause() -> Bool {
        switch state {
        case .completed, .canceling, .suspended:
            return false
        
        case .running:
            suspend()
            return true
        }
    }
}

@discardableResult
public func send(_ request: URLRequest, using session: URLSession = .shared, completion: @escaping (Result<Data>) -> Void) -> NetworkTask {
    let task = session.dataTask(with: request) { data, response, error in
        guard error == nil else {
            completion(.notOkay(error!))
            return
        }
        
        guard response != nil else {
            completion(.notOkay(networkingError("No response received")))
            return
        }
        
        guard data != nil else {
            completion(.notOkay(networkingError("No data received")))
            return
        }
        
        completion(.okay(data!))
    }
    let _: Void = task.resume()
    return task
}

public func send(_ request: URLRequest, using session: URLSession = .shared, semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)) -> Result<Data> {
    var result: Result<Data>?
    send(request) {
        result = $0
        semaphore.signal()
    }
    _ = semaphore.wait(timeout: .distantFuture)
    return result ?? .notOkay(networkingError("Result can not be determined"))
}
