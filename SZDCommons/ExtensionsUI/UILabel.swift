//
//  UILabel.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// results in the attributedText being set
    func setMinimumLineHeight(_ minimumLineHeight: CGFloat) {
        if let text = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = minimumLineHeight
            
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        }
    }
}
