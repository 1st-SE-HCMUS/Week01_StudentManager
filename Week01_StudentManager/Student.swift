//
//  Student.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation

class Student
{
    init() {
        firstName = "Tam"
        lastName = "Tam"
        dateOfBirth = MyDate()
        myClass = MyClass()
        otherInfo = "None"
    }
    var firstName : String
    var lastName : String
    var dateOfBirth : MyDate
    var myClass : MyClass
    var otherInfo : String
}
