//
//  SZDTextField.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public class SZDTextField: UITextField {
    
    public var showCursor: Bool = true
    public var canSelect: Bool = true // TODO: how to disable selection?
    public var canPerformActions: Bool = false
    
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return self.showCursor ? super.caretRect(for: position) : .zero
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // TODO: refine this
//        if !self.canPerformActions &&
//            action == #selector(UIResponderStandardEditActions.copy(_:)) ||
//            action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
//            action == #selector(UIResponderStandardEditActions.paste(_:)) ||
//            action == #selector(UIResponderStandardEditActions.select(_:)) {
//            return false
//        }
        
//        return super.canPerformAction(action, withSender: sender)
        return self.canPerformActions
    }
}
