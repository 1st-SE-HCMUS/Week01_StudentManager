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
        self.id = StudentManager.classList[2].id
        self.name = StudentManager.classList[2].name
    }
    
    init(name : String, id : String) {
        self.name = name
        self.id = id
    }
    
    var name : String
    var id : String
    
    func getIdNumber() -> Int? {
        return Int(id)
    }
}
