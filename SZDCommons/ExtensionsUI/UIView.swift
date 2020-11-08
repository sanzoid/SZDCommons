//
//  UIView.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public extension UIView {
    
    @available(*, deprecated)
    enum VerticalAxis {
        case top
        case bottom
        case both
    }
    
    @available(*, deprecated)
    enum VerticalStyle {
        case topToTop
        case topToBottom
        case bottomToTop
        case bottomToBottom
        case topAndBottom
    }
    
    @available(*, deprecated)
    enum VerticalPosition {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
    }
    
    @available(*, deprecated)
    enum HorizontalAxis {
        case leading
        case trailing
        case both
    }
    
    @available(*, deprecated)
    enum ConstraintDimension {
        case center
        case horizontal
        case vertical
        case edges
        case all
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    func removeSubviews() {
        for view in self.subviews {
            view.removeSubviews()
            view.removeFromSuperview()
        }
    }
    
    @available(*, deprecated)
    func constrainTo(view: UIView, on dimension: ConstraintDimension, constant: CGFloat = 0.0) {
        if dimension == .center || dimension == .all {
            self.constrainToCenter(of: view)
        }
        if dimension == .horizontal || dimension == .edges || dimension == .all {
            self.constrainToHorizontal(of: view, constant: constant)
        }
        if dimension == .vertical || dimension == .edges || dimension == .all {
            self.constrainToVertical(of: view, constant: constant)
        }
    }
    
    @available(*, deprecated)
    func constrainToHorizontal(of view: UIView, axis: HorizontalAxis = .both, constant: CGFloat = 0.0) {
        if axis == .leading || axis == .both {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        }
        if axis == .trailing || axis == .both {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    @available(*, deprecated)
    func constrainToVertical(of view: UIView, axis: VerticalAxis = .both, constant: CGFloat = 0.0) {
        if axis == .top || axis == .both {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        }
        if axis == .bottom || axis == .both {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        }
    }
    
    @available(*, deprecated)
    func constrainToWidthAndHeight(constant: CGFloat) {
        self.constrainToWidth(constant: constant)
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    @available(*, deprecated)
    func constrainToWidth(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    @available(*, deprecated)
    func constrainToHeight(constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func test() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.green.cgColor
    }
}
