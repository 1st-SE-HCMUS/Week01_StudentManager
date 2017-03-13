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
        lastName = "Doan Hieu"
        dateOfBirth = MyDate()
        myClass = MyClass()
        otherInfo = "I dont have time to finish it"
    }
    
    init(firstName : String, lastName : String, dateOfBirth : MyDate, myClass : MyClass, otherInfo : String) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.myClass = myClass
        self.otherInfo = otherInfo
    }
    
    var firstName : String
    var lastName : String
    var dateOfBirth : MyDate
    var myClass : MyClass
    var otherInfo : String
}
