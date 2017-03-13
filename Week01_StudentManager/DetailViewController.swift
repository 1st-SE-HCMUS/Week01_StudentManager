//
//  ViewController.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var edFirstNam: UITextField!
    
    @IBOutlet weak var edLastName: UITextField!

    @IBOutlet weak var edOtherInfo: UITextField!
    
    @IBOutlet weak var classPicker: UIPickerView!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func btnSave(_ sender: UIButton) {
        var student : Student = Student(firstName: edFirstNam.text!, lastName: edLastName.text!, dateOfBirth: MyDate(), myClass: MyClass(), otherInfo: edOtherInfo.text!)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var s:Student = StudentManager.studentList[StudentManager.selectedIndex]
        
        edFirstNam.text = s.firstName
        edLastName.text = s.lastName
        edOtherInfo.text = s.otherInfo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

