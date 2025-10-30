//
//  DateFormatter +.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/30/25.
//

import Foundation



extension Date {
    public func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = .current
        
        let result = formatter.string(from: self)
        return result
    }
}
