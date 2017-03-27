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
        day = 1
        month = 1
        year = 1996
    }
    
    init(day : Int, month : Int, year : Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    var day : Int
    var month : Int
    var year : Int
}
