//
//  ViewController.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import UIKit

public func viewControllerFromStoryboard<T: UIViewController>(with name: String) -> T {
    let bundle = Bundle(for: T.self)
    let storyboard = UIStoryboard(name: name, bundle: bundle)
    let screen = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    return screen
}
