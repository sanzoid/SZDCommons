//
//  UIView+ConstraintEnum.swift
//  GoogleUtilities
//
//  Created by Sandy House on 2020-11-08.
//

import Foundation

public extension UIView {
    /// the relativity between base view and constraint view/constant
    enum ConstraintRelativity {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
    }
    
    /// the placement of a size from base view to constraint view
    enum SizePlacement {
        case widthToWidth
        case widthToHeight
        case heightToWidth
        case heightToHeight
        case widthAndHeight
    }
    
    /// the size dimension for constant size constraints
    enum SizeDimension {
        case width
        case height
        case both
    }
    
    /// the axis of a center constraint
    enum CenterAxis {
        case x
        case y
        case both
    }
    
    /// the placement of an edge from base view to constraint view
    enum EdgePlacement {
        // vertical
        case topToTop
        case topToBottom
        case bottomToTop
        case bottomToBottom
        case topAndBottom
        // horizontal
        case leadingToLeading
        case leadingToTrailing
        case trailingToLeading
        case trailingToTrailing
        case leadingAndTrailing
        // all
        case all
    }
}
