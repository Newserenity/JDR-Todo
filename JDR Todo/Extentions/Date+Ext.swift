//
//  Date+Ext.swift
//  JDR Todo
//
//  Created by Jeff Jeong on 2023/06/06.
//

import Foundation

extension Date {
    
    static func makeDateString(original originalDateString: String,
                        format: String = "yyyy/MM/dd hh:mm EE") -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        guard let currentDate : Date = dateFormatter.date(from: originalDateString) else { return nil }
        
        return currentDate.toString(format)
    }
    
    func toString(_ format: String = "yyyy.mm.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
  
}
