//
//  UIAlertController.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    typealias TextFieldHandler = ((UITextField) -> Void)
    
//    convenience init(title: String? = nil,
//                     message: String? = nil,
//                     preferredStyle: UIAlertAction.Style,
//                     actions: [ActionProperties]? = nil,
//                     textFields: [TextFieldHandler]? = nil) {
//        self.init(title: title, message: nil, preferredStyle: .alert)
//
//        textFields?.forEach{ textField in
//            self.addTextField { alertTextField in
//                textField(alertTextField)
//            }
//        }
//
//        actions.forEach{ action in
//            let action = UIAlertAction(title: action.title, style: action.style, handler: action.handler)
//            self.addAction(action)
//        }
//    }
    
    func addActions(_ actions: UIAlertAction...) {
        actions.forEach{ action in
            self.addAction(action)
        }
    }
    
    func addTextFields(_ textFields: TextFieldHandler...) {
        textFields.forEach{ textField in
            self.addTextField { alertTextField in
                textField(alertTextField)
            }
        }
    }
    
    func addTextFields(_ prefills: (placeholder: String?, text: String?)...) {
        prefills.forEach { prefill in
            let textFieldHandler = { (textField: UITextField) in
                textField.placeholder = prefill.placeholder
                textField.text = prefill.text
            }
            
            self.addTextField { textField in
                textFieldHandler(textField)
            }
        }
    }
}
