//
//  Class.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation

class MyClass
{
    init()
    {
        name = "Swift programming"
        id = "TH2014"
    }
    
    init(name : String, id : String) {
        self.name = name
        self.id = id
    }
    
    var name : String
    var id : String
}
