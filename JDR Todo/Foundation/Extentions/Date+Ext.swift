//
//  Date+Ext.swift
//  JDR Todo
//
//  Created by Jeff Jeong on 2023/06/06.
//

import Foundation

/**
 - Description: 날짜 변환 확장
 */
extension Date {
    
    //MARK: - Custom Method
    /**
     - Description: makeDateString 1번째 파람에서 넘겨받을 값을 특정한 형식으로 돌려주는 메소드
     - Warning: originalDateString은 무조건 "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'" 형식이어야 합니다
     ```
     Date.makeDateString(original: "***")
     ```
     */
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
