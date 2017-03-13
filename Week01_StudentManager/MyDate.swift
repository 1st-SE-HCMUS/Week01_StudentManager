//
//  Date.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation


class MyDate
{
    init() {
        day = "1"
        month = "1"
        year = "1996"
    }
    
    init(day : String, month : String, year : String) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    var day : String
    var month : String
    var year : String
}
