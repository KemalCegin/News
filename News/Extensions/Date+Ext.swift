//
//  Date+Ext.swift
//  News
//
//  Created by Kemal Cegin on 9.01.2023.
//

import Foundation

extension Date {
    
    func convertToMonthToYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "E, d MMM yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
