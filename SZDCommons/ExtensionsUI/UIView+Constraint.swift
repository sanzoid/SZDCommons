//
//  UIView+Constraint.swift
//  GoogleUtilities
//
//  Created by Sandy House on 2020-11-08.
//

import UIKit

public extension UIView {
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
    /// the relativity between base view and constraint view/constant
    enum ConstraintRelativity {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
    }
    /// the axis of a center constraint 
    enum CenterAxis {
        case x
        case y
        case both
    }
    
    // MARK: Center
    func constrainToCenter(of view: UIView,
                           axis: CenterAxis,
                           constant: CGFloat = 0.0,
                           relativity: ConstraintRelativity,
                           priority: UILayoutPriority = .defaultHigh) {
        
        if axis == .both {
            self.constrainToCenter(of: view, axis: .x, constant: constant, relativity: relativity, priority: priority)
            self.constrainToCenter(of: view, axis: .x, constant: constant, relativity: relativity, priority: priority)
            return
        }
        
        var constraint: NSLayoutConstraint
        if axis == .x {
            let baseAnchor = self.centerXAnchor
            let constraintAnchor = view.centerXAnchor
            constraint = self.applyAnchorConstraint(baseAnchor: baseAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
        } else {
            let baseAnchor = self.centerYAnchor
            let constraintAnchor = view.centerYAnchor
            constraint = self.applyAnchorConstraint(baseAnchor: baseAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
        }
        constraint.isActive = true
        constraint.priority = priority
    }
    
    // MARK: Size
    
    /// constraint to constant size
    func constrainToSize(constant: CGFloat, dimension: SizeDimension = .both, relativity: ConstraintRelativity, priority: UILayoutPriority = .defaultHigh) {
        if dimension == .both {
            self.constrainToSize(constant: constant, dimension: .width, relativity: relativity)
            self.constrainToSize(constant: constant, dimension: .height, relativity: relativity)
            return
        }
        
        let anchor = dimension == .width ? self.widthAnchor : self.heightAnchor
        
        var constraint: NSLayoutConstraint
        switch relativity {
        case .equal:
            constraint = anchor.constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        }
        constraint.isActive = true
        constraint.priority = priority
    }
    
    /// constrain to size of view
    func constrainToSize(of view: UIView, placement: SizePlacement = .widthAndHeight, relativity: ConstraintRelativity = .equal, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .defaultHigh) {
        if placement == .widthAndHeight {
            self.constrainToSize(of: view, placement: .widthToWidth, relativity: relativity, multiplier: multiplier, priority: priority)
            self.constrainToSize(of: view, placement: .heightToHeight, relativity: relativity, multiplier: multiplier, priority: priority)
            return
        }
        
        var baseAnchor: NSLayoutDimension
        switch placement {
        case .widthToWidth, .widthToHeight:
            baseAnchor = self.widthAnchor
        case .heightToWidth, .heightToHeight:
            baseAnchor = self.heightAnchor
        case .widthAndHeight:
            fatalError("SizeDimension.widthAndHeight should never reach this point")
        }
        
        var anchor: NSLayoutDimension
        switch placement {
        case .widthToWidth, .heightToWidth:
            anchor = view.widthAnchor
        case .widthToHeight, .heightToHeight:
            anchor = view.heightAnchor
        case .widthAndHeight:
            fatalError("SizeDimension.widthAndHeight should never reach this point")
        }
        
        if placement == .widthToWidth || placement == .heightToWidth {
            let constraint = self.applyDimensionConstraint(baseAnchor: baseAnchor, constraintAnchor: anchor, relativity: relativity, multiplier: multiplier, constant: constant)
            constraint.isActive = true
            constraint.priority = priority
        }
    }
    
    // MARK: Edge
    // TODO: Refactor this
    
    func constrainToEdge(of view: UIView,
                         placement: EdgePlacement,
                         relativity: ConstraintRelativity = .equal,
                         constant: CGFloat = 0.0,
                         priority: UILayoutPriority = .defaultHigh) {
        if placement == .all {
            self.constrainToEdge(of: view, placement: .topAndBottom, relativity: relativity, constant: constant, priority: priority)
            self.constrainToEdge(of: view, placement: .leadingAndTrailing, relativity: relativity, constant: constant, priority: priority)
            return
        }
        
        switch placement {
        case .topToTop, .topToBottom, .bottomToTop, .bottomToBottom, .topAndBottom:
            self.constrainToEdgeVertical(of: view, placement: placement, relativity: relativity, constant: constant, priority: priority)
            
        case .leadingToLeading, .leadingToTrailing, .trailingToLeading, .trailingToTrailing, .leadingAndTrailing:
            self.constrainToEdgeHorizontal(of: view, placement: placement, relativity: relativity, constant: constant, priority: priority)
        default:
            fatalError("constrainToEdge reached default")
        }
    }
    
    private func constrainToEdgeVertical(of view: UIView,
                         placement: EdgePlacement,
                         relativity: ConstraintRelativity = .equal,
                         constant: CGFloat = 0.0,
                         priority: UILayoutPriority = .defaultHigh) {
        // base anchor
        var topAnchor: NSLayoutYAxisAnchor?
        if placement == .topToTop || placement == .topToBottom || placement == .topAndBottom {
            topAnchor = self.topAnchor
        }
        var bottomAnchor: NSLayoutYAxisAnchor?
        if placement == .bottomToTop || placement == .bottomToBottom || placement == .topAndBottom {
            bottomAnchor = self.bottomAnchor
        }
        
        // apply constraint
        if let topAnchor = topAnchor {
            let constraintAnchor = placement == .topToBottom ? view.bottomAnchor : view.topAnchor
            let constant = constant
            let constraint = self.applyAnchorConstraint(baseAnchor: topAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
            constraint.isActive = true
            constraint.priority = priority
        }
        if let bottomAnchor = bottomAnchor {
            let constraintAnchor = placement == .bottomToTop ? view.topAnchor : view.bottomAnchor
            let constant = -constant
            let constraint = self.applyAnchorConstraint(baseAnchor: bottomAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
            constraint.isActive = true
            constraint.priority = priority
        }
    }
    
    private func constrainToEdgeHorizontal(of view: UIView,
                                   placement: EdgePlacement,
                                   relativity: ConstraintRelativity = .equal,
                                   constant: CGFloat = 0.0,
                                   priority: UILayoutPriority = .defaultHigh) {
        // base anchor
        var leadingAnchor: NSLayoutXAxisAnchor?
        if placement == .leadingToLeading || placement == .leadingToTrailing || placement == .leadingAndTrailing {
            leadingAnchor = self.leadingAnchor
        }
        var trailingAnchor: NSLayoutXAxisAnchor?
        if placement == .trailingToLeading || placement == .trailingToTrailing || placement == .leadingAndTrailing {
            trailingAnchor = self.trailingAnchor
        }
        
        // apply constraint
        if let leadingAnchor = leadingAnchor {
            let constraintAnchor = placement == .leadingToTrailing ? view.trailingAnchor : view.leadingAnchor
            let constant = constant
            let constraint = self.applyAnchorConstraint(baseAnchor: leadingAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
            constraint.isActive = true
            constraint.priority = priority
        }
        if let trailingAnchor = trailingAnchor {
            let constraintAnchor = placement == .trailingToLeading ? view.leadingAnchor : view.trailingAnchor
            let constant = -constant
            let constraint = self.applyAnchorConstraint(baseAnchor: trailingAnchor, constraintAnchor: constraintAnchor, relativity: relativity, constant: constant)
            constraint.isActive = true
            constraint.priority = priority
        }
    }
    
    // MARK: Helper
    
    private func applyDimensionConstraint(baseAnchor: NSLayoutDimension, constraintAnchor: NSLayoutDimension, relativity: ConstraintRelativity, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        switch relativity {
        case .equal:
            constraint = baseAnchor.constraint(equalTo: constraintAnchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            constraint = baseAnchor.constraint(greaterThanOrEqualTo: constraintAnchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            constraint = baseAnchor.constraint(lessThanOrEqualTo: constraintAnchor, multiplier: multiplier, constant: constant)
        }
        return constraint
    }
    
    private func applyAnchorConstraint<T>(baseAnchor: NSLayoutAnchor<T>, constraintAnchor: NSLayoutAnchor<T>, relativity: ConstraintRelativity, constant: CGFloat) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        switch relativity {
        case .equal:
            constraint = baseAnchor.constraint(equalTo: constraintAnchor, constant: constant)
        case .greaterThanOrEqual:
            constraint = baseAnchor.constraint(greaterThanOrEqualTo: constraintAnchor, constant: constant)
        case .lessThanOrEqual:
            constraint = baseAnchor.constraint(lessThanOrEqualTo: constraintAnchor, constant: constant)
        }
        return constraint
    }
}
