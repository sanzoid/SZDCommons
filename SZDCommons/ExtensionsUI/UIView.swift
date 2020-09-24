//
//  UIView.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public extension UIView {
    
    enum VerticalAxis {
        case top
        case bottom
        case both
    }
    enum HorizontalAxis {
        case leading
        case trailing
        case both
    }
    enum CenterAxis {
        case x
        case y
        case both
    }
    
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
    
    func constrainToCenter(of view: UIView, axis: CenterAxis = .both, constant: CGFloat = 0.0) {
        if axis == .x || axis == .both {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        }
        if axis == .y || axis == .both {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        }
    }
    
    func constrainToHorizontal(of view: UIView, axis: HorizontalAxis = .both, constant: CGFloat = 0.0) {
        if axis == .leading || axis == .both {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        }
        if axis == .trailing || axis == .both {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    func constrainToVertical(of view: UIView, axis: VerticalAxis = .both, constant: CGFloat = 0.0) {
        if axis == .top || axis == .both {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        }
        if axis == .bottom || axis == .both {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        }
    }
    
    func constrainToWidthAndHeight(constant: CGFloat) {
        self.constrainToWidth(constant: constant)
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func constrainToWidth(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainToHeight(constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func test() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.green.cgColor
    }
}
