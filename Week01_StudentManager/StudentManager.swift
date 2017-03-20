//
//  StudentManager.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation


final class StudentManager {
    
    //MARK: Local Variable
    
    var studentList:[Student]!
    static var classList:[MyClass]! = [MyClass(name: "14 CTT1", id: "1"), MyClass(name: "14 CTT2", id: "2"), MyClass(name: "14 CTT3", id: "3"), MyClass(name: "14 CNTN", id: "4")]
    
    init() {
        studentList = [Student]()
    }
    
    
    public func addStudent(student:Student?)
    {
        studentList.append(student!)
    }
    
    public func insertStudent(student:Student?, index:Int)
    {
        studentList.insert(student!, at: index)
    }
    
    public func updateStudent(student:Student?, index:Int)
    {
        studentList[index] = student!
    }
    
    public func getStudent(index : Int) -> Student
    {
        return studentList[index]
    }
    
    public func removeStudent(index : Int)
    {
        studentList.remove(at: index)
    }
    
    public func getStudentList() -> [Student]
    {
        return studentList
    }
    
    public func getClass(index: Int) -> MyClass
    {
        return StudentManager.classList[index]
    }
}
