//
//  DateHelpers.swift
//  Task
//
//  Created by Brady Bentley on 12/5/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
