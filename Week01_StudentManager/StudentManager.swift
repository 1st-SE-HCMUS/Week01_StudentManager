//
//  StudentManager.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation


final class StudentManager {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: StudentManager = StudentManager()
    
    public static func getInstance() -> StudentManager
    {
        return sharedInstance
    }
    
    //MARK: Local Variable
    
    static var studentList:[Student]!
    static var classList:[MyClass]! = [MyClass(name: "14 CTT1", id: "1"), MyClass(name: "14 CTT2", id: "2"), MyClass(name: "14 CTT3", id: "3"), MyClass(name: "14 CNTN", id: "4")]
    
    /*
    public func addStudent(student:Student?)
    {
        studentList.append(student!)
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
    */
    
}
