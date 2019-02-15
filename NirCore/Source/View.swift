//
//  View.swift
//  NirCore
//
//  Created by Mounir Ybanez on 2/14/19.
//  Copyright © 2019 Nir. All rights reserved.
//

import UIKit

public func dequeueCell<T: UITableViewCell>(from tableView: UITableView, with identifier: String) -> T {
    return tableView.dequeueReusableCell(withIdentifier: identifier) as! T
}

public func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(from tableView: UITableView, with identifier: String) -> T {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
}

public func dequeueCell<T: UICollectionViewCell>(from collectionView: UICollectionView, with identifier: String, for indexPath: IndexPath) -> T {
    return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
}

public func dequeueSupplementaryView<T: UICollectionReusableView>(from collectionView: UICollectionView, of kind: String, with identifier: String, for indexPath: IndexPath) -> T {
    return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as! T
}
