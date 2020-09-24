//
//  UIViewController.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func addChildDefault(viewController: UIViewController, with frame: CGRect? = nil) {
        self.addChild(viewController)
        if let frame = frame {
            viewController.view.frame = frame
            self.view.addSubview(viewController.view)
        } else {
            self.view.addSubviews(viewController.view)
        }
        viewController.didMove(toParent: self)
    }
    
    func removeFromParentDefault() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
