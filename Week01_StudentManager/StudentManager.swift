//
//  StudentManager.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation
import CoreData

class StudentManager {
    
    //MARK: Local Variable
    var sqliteHelper: SQLiteHelper
    var dbName: String
    
    var studentList:[Student]!
    static var classList:[MyClass]! = [MyClass(name: "14 CTT1", id: "1"), MyClass(name: "14 CTT2", id: "2"), MyClass(name: "14 CTT3", id: "3"), MyClass(name: "14 CNTN", id: "4")]
    
    init(dbName: String) {
        studentList = [Student]()
        self.dbName = dbName
        sqliteHelper = SQLiteHelper.getInstance(dbName: self.dbName)
    }
    
    public func fetchStudentFromDb()
    {
        studentList = sqliteHelper.selectStudent(selectQuery: "SELECT * FROM StudentManager")
    }
    
    
    public func updateAllStudentToDb()
    {
        sqliteHelper.deleteAll()
        sqliteHelper.insert(studentArray: studentList)
    }
    
    public func updateStudentToDb(editedIndex: Int)
    {
        sqliteHelper.update(student: studentList[editedIndex])
    }
    
    
    
    public func addStudentToDb(newStudent: Student)
    {
        sqliteHelper.insertStudent(newStudent: newStudent)
    }
    
    
    
    
    public func deleteStudentFromDb(deletedIndex:Int)
    {
        sqliteHelper.delete(student: studentList[deletedIndex])
    }
    
    
    
    
    public func addStudent(newStudent:Student?)
    {
        studentList.append(newStudent!)
    }
    
    public func insertStudent(newStudent:Student?, index:Int)
    {
        studentList.insert(newStudent!, at: index)
    }
    
    public func updateStudent(newStudent:Student?, index:Int)
    {
        studentList[index] = newStudent!
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
