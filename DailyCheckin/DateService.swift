//
//  DateService.swift
//  DailyCheckin
//
//  Created by ryo fuj on 2/2/22.
//

import Foundation

class DateService {
    private init() {}
    static let shared = DateService()
    
    var dateFormatter: DateFormatter  = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
