//
//  Date+Extension.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/14.
//  Copyright © 2019 Jash. All rights reserved.
//

import Foundation
import DateToolsSwift

extension Date {
    func isSameDay(date: Date, calendar: Calendar) -> Bool {
        var components = calendar.dateComponents([.era, .year, .month, .day], from: date)
        let dateOne = calendar.date(from: components)
        
        components = calendar.dateComponents([.era, .year, .month, .day], from: self)
        let dateTwo = calendar.date(from: components)
        
        return (dateOne?.equals(dateTwo!))!
    }
}
