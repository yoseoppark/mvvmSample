//
//  DateExtension.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/08.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: self)
    }
}
