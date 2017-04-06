//
//  File.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 4/6/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation
import CoreData


class CoreDataHelper
{
    var delegate: AppDelegate
    var context:NSManagedObjectContext
    
    
    init(delegate: AppDelegate, context:NSManagedObjectContext) {
        self.delegate = delegate
        self.context = context
    }
    

    public func fetchStudentFromCoreData(studentArray:[ClassStudent]) -> [Student]
    {
        var studentList:[Student] = [Student]()
        
        for student in studentArray {
            //Make sure the value is not nil
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
            
            //add to list
            studentList.append(Student(firstName: student.firstName!, lastName: student.lastName!, dateOfBirth: MyDate(day: Int(student.birthDate), month: Int(student.birthMonth), year: Int(student.birthYear)), myClass: MyClass(name: student.classNameStr!, id: student.classId!), otherInfo: student.otherInfo!))
        }
        
        return studentList
    }
    
    
    public func updateAllStudentToCoreData(students: [Student], request:NSFetchRequest<ClassStudent>)
    {
        //Update Core Data
        do {
            var oldStudents = try context.fetch(request)
            
            for i in 0...oldStudents.count - 1 {
                let newStudent:Student = students[i]
                oldStudents[i].firstName = newStudent.firstName
                oldStudents[i].lastName = newStudent.lastName
                oldStudents[i].classId = newStudent.myClass.id
                oldStudents[i].classNameStr = newStudent.myClass.name
                oldStudents[i].birthDate = Int32(newStudent.dateOfBirth.day)
                oldStudents[i].birthMonth = Int32(newStudent.dateOfBirth.month)
                oldStudents[i].birthYear = Int32(newStudent.dateOfBirth.year)
                oldStudents[i].otherInfo = newStudent.otherInfo
            }
            
            delegate.saveContext()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    public func updateStudentToCoreData(newStudent: Student, editedIndex: Int, request:NSFetchRequest<ClassStudent>)
    {
        //Update Core Data
        do {
            var students = try context.fetch(request)
            
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
    
    
    public func addStudentToCoreData(newStudent:Student)
    {
        let newClassStudent = ClassStudent(context: context)
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
    
    
    public func deleteStudentFromCoreData(deletedIndex:Int, request:NSFetchRequest<ClassStudent>)
    {
        do {
            let students = try context.fetch(request)
            
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
    
    
    deinit {
        
    }
}
