//
//  DateFormatter.swift
//  SZDCommons
//
//  Created by Sandy House on 2020-09-24.
//  Copyright © 2020 sandzapps. All rights reserved.
//

import Foundation

public extension DateFormatter {
    
    convenience init(dateStyle: Style, timeStyle: Style) {
        self.init()
        
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}
