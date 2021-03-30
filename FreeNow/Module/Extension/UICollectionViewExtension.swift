//
//  ReusableUIViewExtension.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(withCellType: T.Type) where T: Reuseable {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<Base: UICollectionViewCell & Reuseable >(forIndexPath indexPath: IndexPath) -> Base {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: Base.reuseIdentifier, for: indexPath) as? Base {
            return cell
        } else {
            fatalError("can not dequeue cell with reusableIdentifier '\(Base.reuseIdentifier)' at indexPath '\(indexPath)'")
        }
    }
}
