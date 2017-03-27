//
//  ClassStudent+CoreDataProperties.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/27/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import Foundation
import CoreData


extension ClassStudent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassStudent> {
        return NSFetchRequest<ClassStudent>(entityName: "ClassStudent");
    }

    @NSManaged public var birthDate: Int32
    @NSManaged public var birthMonth: Int32
    @NSManaged public var birthYear: Int32
    @NSManaged public var classId: String?
    @NSManaged public var classNameStr: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var otherInfo: String?

}
