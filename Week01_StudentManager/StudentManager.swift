//
//  StudentManager.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation
import CoreData

final class StudentManager {
    
    //MARK: Local Variable
    
    var studentList:[Student]!
    static var classList:[MyClass]! = [MyClass(name: "14 CTT1", id: "1"), MyClass(name: "14 CTT2", id: "2"), MyClass(name: "14 CTT3", id: "3"), MyClass(name: "14 CNTN", id: "4")]
    
    init() {
        studentList = [Student]()
    }
    
    public func fetchStudentFromDb(studentArray:[ClassStudent])
    {
        for student in studentArray {
            if student.firstName == nil {
                student.firstName = ""
            }
            if student.lastName == nil {
                student.lastName = ""
            }
            if student.classNameStr == nil {
                student.classNameStr = "14 CTT1"
            }
            if student.classId == nil {
                student.classId = "1"
            }
            if student.otherInfo == nil {
                student.otherInfo = ""
            }
            
            studentList.append(Student(firstName: student.firstName!, lastName: student.lastName!, dateOfBirth: MyDate(day: Int(student.birthDate), month: Int(student.birthMonth), year: Int(student.birthYear)), myClass: MyClass(name: student.classNameStr!, id: student.classId!), otherInfo: student.otherInfo!))
        }
    }
    
    public func updateAllStudentFromDb(delegate: AppDelegate, context:NSManagedObjectContext, request:NSFetchRequest<ClassStudent>)
    {
        //Update Core Data
        do {
            var students = try context.fetch(request)
            
            for i in 0...students.count - 1 {
                var newStudent:Student = getStudent(index: i)
                students[i].firstName = newStudent.firstName
                students[i].lastName = newStudent.lastName
                students[i].classId = newStudent.myClass.id
                students[i].classNameStr = newStudent.myClass.name
                students[i].birthDate = Int32(newStudent.dateOfBirth.day)
                students[i].birthMonth = Int32(newStudent.dateOfBirth.month)
                students[i].birthYear = Int32(newStudent.dateOfBirth.year)
                students[i].otherInfo = newStudent.otherInfo
            }
            
            delegate.saveContext()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func updateStudentFromDb(editedIndex:Int, delegate: AppDelegate, context:NSManagedObjectContext, request:NSFetchRequest<ClassStudent>)
    {
        //Update Core Data
        do {
            var students = try context.fetch(request)
            var newStudent:Student = getStudent(index: editedIndex)
            
            for i in 0...students.count - 1 {
                if i == editedIndex {
                    students[i].firstName = newStudent.firstName
                    students[i].lastName = newStudent.lastName
                    students[i].classId = newStudent.myClass.id
                    students[i].classNameStr = newStudent.myClass.name
                    students[i].birthDate = Int32(newStudent.dateOfBirth.day)
                    students[i].birthMonth = Int32(newStudent.dateOfBirth.month)
                    students[i].birthYear = Int32(newStudent.dateOfBirth.year)
                    students[i].otherInfo = newStudent.otherInfo
                }
            }
            
            delegate.saveContext()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func addStudentToDb(newStudent:Student, delegate: AppDelegate, context:NSManagedObjectContext)
    {
        var newClassStudent = ClassStudent(context: context)
        newClassStudent.firstName = newStudent.firstName
        newClassStudent.lastName = newStudent.lastName
        newClassStudent.birthDate = Int32(newStudent.dateOfBirth.day)
        newClassStudent.birthMonth = Int32(newStudent.dateOfBirth.month)
        newClassStudent.birthYear = Int32(newStudent.dateOfBirth.year)
        newClassStudent.classNameStr = newStudent.myClass.name
        newClassStudent.classId = newStudent.myClass.id
        newClassStudent.otherInfo = newStudent.otherInfo
        
        delegate.saveContext()
    }
    
    public func deleteStudentFromDb(deletedIndex:Int, delegate: AppDelegate, context:NSManagedObjectContext, request:NSFetchRequest<ClassStudent>)
    {
        do {
            var students = try context.fetch(request)
            
            var idx:Int = 0
            for student in students {
                if idx == deletedIndex {
                    context.delete(student)
                }
                idx+=1
            }
            
            delegate.saveContext()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
