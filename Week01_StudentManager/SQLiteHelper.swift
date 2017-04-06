//
//  SQLiteHelper.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 4/4/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation

class SQLiteHelper {
    private let dbPointer: OpaquePointer

    private init(db: OpaquePointer) {
        self.dbPointer = db
        createTable(createQuery: "CREATE TABLE StudentManager(id INT PRIMARY KEY NOT NULL, firstName CHAR(255), lastName CHAR(255), classId CHAR(255), className CHAR(255), birthDate INT, birthMonth INT, birthYear INT, otherInfo CHAR(255));")
    }
    
    
    static func getInstance(dbName: String) -> SQLiteHelper {
        var db: OpaquePointer? = nil
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let dataPath = doc.appendingPathComponent(dbName).path
        
        //Attempt to open the database at the provided path
        if sqlite3_open(dataPath, &db) == SQLITE_OK {
            //If successful, return a new instance of SQLiteDatabase
            print("Db created!")
            return SQLiteHelper(db: db!)
        } else {
            if let message = sqlite3_errmsg(db) {
                print(message)
            }
            return SQLiteHelper(db: db!)
        }
    }
    
    
    func createTable(createQuery: String) {
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, createQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            //Db prepared
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                //Table created
                print("Table Created")
            }
            else {
                print("Table could not be created")
            }
        }
        else {
            if let message = sqlite3_errmsg(dbPointer) {
                print(String(cString: message))
            }
            print("Database prepare for createTable failed")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func selectStudent(selectQuery: String) -> [Student] {
        var queryStatement: OpaquePointer? = nil
        var studentList: [Student] = [Student]()
        if sqlite3_prepare_v2(dbPointer, selectQuery, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var newStudent:Student = Student()
                newStudent.id = String(cString: sqlite3_column_text(queryStatement, 0)!)
                newStudent.firstName = String(cString: sqlite3_column_text(queryStatement, 1)!)
                newStudent.lastName = String(cString: sqlite3_column_text(queryStatement, 2)!)
                newStudent.myClass.id = String(cString: sqlite3_column_text(queryStatement, 3)!)
                newStudent.myClass.name = String(cString: sqlite3_column_text(queryStatement, 4)!)
                newStudent.dateOfBirth.day = Int(sqlite3_column_int(queryStatement, 5))
                newStudent.dateOfBirth.month = Int(sqlite3_column_int(queryStatement, 6))
                newStudent.dateOfBirth.year  = Int(sqlite3_column_int(queryStatement, 7))
                newStudent.otherInfo = String(cString: sqlite3_column_text(queryStatement, 8)!)
                
                studentList.append(newStudent)
            }
        }
        else {
            print("Database prepare for selectStudent failed")
        }
        return studentList
    }
    
    func insertStudent(newStudent: Student) {
        //Update
        var insertQuery = "INSERT INTO StudentManager(id, firstName, lastName, classId, className, birthDate, birthMonth, birthYear, otherInfo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var sqlStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(dbPointer, insertQuery, -1, &sqlStatement, nil) == SQLITE_OK {
            //Db prepared
            sqlite3_bind_text(sqlStatement, 1, NSString(string: newStudent.id).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 2, NSString(string: newStudent.firstName).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 3, NSString(string: newStudent.lastName).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 4, NSString(string: newStudent.myClass.id).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 5, NSString(string: newStudent.myClass.name).utf8String, -1, nil)
                sqlite3_bind_int(sqlStatement, 6, Int32(newStudent.dateOfBirth.day))
                sqlite3_bind_int(sqlStatement, 7, Int32(newStudent.dateOfBirth.month))
                sqlite3_bind_int(sqlStatement, 8, Int32(newStudent.dateOfBirth.year))
                sqlite3_bind_text(sqlStatement, 9, NSString(string: newStudent.otherInfo).utf8String, -1, nil)
                if sqlite3_step(sqlStatement) == SQLITE_DONE {
                    print("Data updated")
                }
                else {
                    print("Data could not be updated")
                }
        }
        else {
            print("Database prepare for insertStudent failed")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    
    func insert(studentArray:[Student]) {
        //Update
        var updateQuery = "INSERT INTO StudentManager(id, firstName, lastName, classId, className, birthDate, birthMonth, birthYear, otherInfo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var sqlStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(dbPointer, updateQuery, -1, &sqlStatement, nil) == SQLITE_OK {
            //Db prepared
            for student in studentArray {
                sqlite3_bind_text(sqlStatement, 1, NSString(string: student.id).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 2, NSString(string: student.firstName).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 3, NSString(string: student.lastName).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 4, NSString(string: student.myClass.id).utf8String, -1, nil)
                sqlite3_bind_text(sqlStatement, 5, NSString(string: student.myClass.name).utf8String, -1, nil)
                sqlite3_bind_int(sqlStatement, 6, Int32(student.dateOfBirth.day))
                sqlite3_bind_int(sqlStatement, 7, Int32(student.dateOfBirth.month))
                sqlite3_bind_int(sqlStatement, 8, Int32(student.dateOfBirth.year))
                sqlite3_bind_text(sqlStatement, 9, NSString(string: student.otherInfo).utf8String, -1, nil)
                if sqlite3_step(sqlStatement) == SQLITE_DONE {
                    print("Data inserted")
                }
                else {
                    print("Data could not be inserted")
                }
                
                sqlite3_reset(sqlStatement)
            }
        }
        else {
            print("Database prepare for insert all student failed")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    
    public func update(student: Student)
    {
        //Update
        var updateQuery = "UPDATE StudentManager SET firstName = '\(student.firstName)', lastName = '\(student.lastName)', classId = '\(student.myClass.id)', className = '\(student.myClass.name)', birthDate = \(student.dateOfBirth.day), birthMonth = \(student.dateOfBirth.month), birthYear = \(student.firstName)  WHERE id = '\(student.id)'"
        var sqlStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(dbPointer, updateQuery, -1, &sqlStatement, nil) == SQLITE_OK {
            
                if sqlite3_step(sqlStatement) == SQLITE_DONE {
                    print("Data updated")
                }
                else {
                    print("Data could not be updated")
                }
        }
        else {
            print("Database prepare for updateStudent failed")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    
    public func delete(student: Student)
    {
        var sqlStatement: OpaquePointer? = nil
        var deleteQuery = "DELETE FROM StudentManager WHERE id = '\(student.id)'"
        
        if sqlite3_prepare_v2(dbPointer, deleteQuery, -1, &sqlStatement, nil) == SQLITE_OK {
            //Db prepared
            
            if sqlite3_step(sqlStatement) == SQLITE_DONE {
                //Table created
                print("Deleted")
            }
            else {
                print("Error occur when deleting records")
            }
        }
        else {
            print("Database prepare for delete all student failed")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    
    
    public func deleteAll()
    {
        var sqlStatement: OpaquePointer? = nil
        var deleteQuery = "DELETE FROM StudentManager"
        
        if sqlite3_prepare_v2(dbPointer, deleteQuery, -1, &sqlStatement, nil) == SQLITE_OK {
            //Db prepared
            
            if sqlite3_step(sqlStatement) == SQLITE_DONE {
                //Table created
                print("Deleted")
            }
            else {
                print("Error occur when deleting records")
            }
        }
        else {
            if let message = sqlite3_errmsg(dbPointer) {
                print(String(cString: message))
            }
            print("Database prepare for delete all student failed")
            
        }
        
        sqlite3_finalize(sqlStatement)
    }
    

    deinit {
        sqlite3_close(dbPointer)
    }
}
