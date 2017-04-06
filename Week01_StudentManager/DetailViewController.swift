//
//  ViewController.swift
//  Week01_StudentManager
//
//  Created by Genius Doan on 3/13/17.
//  Copyright © 2017 IceteaViet. All rights reserved.
//

import UIKit

protocol DetailVCDelegate : class {
    func saveData(student: Student, studentIndex:Int?, mode:Int?)
}

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currStudent:Student?
    var currClass: MyClass = MyClass()
    var studentIndex: Int?
    var viewMode: Int?
    var isEditting:Bool = false
    
    weak var delegate : DetailVCDelegate?

    @IBOutlet weak var edFirstNam: UITextField!
    
    @IBOutlet weak var edLastName: UITextField!

    @IBOutlet weak var edOtherInfo: UITextField!
    
    @IBOutlet weak var classPicker: UIPickerView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        if viewMode == ListStudentViewController.MODE_ADD {
            saveDataAndDismiss()
            _ = navigationController?.popViewController(animated: true)
        }
        else
        {
            if isEditting {
                saveDataAndDismiss()
                _ = navigationController?.popViewController(animated: true)
            }
            else
            {
                enableViewForEditting()
            }
        }
    }
    
    
    @IBAction func btnBackTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (viewMode == ListStudentViewController.MODE_EDIT)
        {
            edFirstNam.text = currStudent!.firstName
            edLastName.text = currStudent!.lastName
            edOtherInfo.text = currStudent!.otherInfo
            let classIndex = (currStudent?.myClass.getIdNumber())! - 1
            classPicker.selectRow(classIndex, inComponent: 0, animated: true)
            currClass = currStudent!.myClass
            
            // Specify date components
            var dateComponents = DateComponents()
            dateComponents.year = currStudent?.dateOfBirth.year
            dateComponents.month = currStudent?.dateOfBirth.month
            dateComponents.day = currStudent?.dateOfBirth.day
            
            // Create date from components
            let userCalendar = Calendar(identifier: .gregorian)
            
            datePicker.setDate(userCalendar.date(from: dateComponents)!, animated: true)
            btnSave.setTitle("Edit", for: .normal)
        }
        else
        {
            enableViewForEditting()
            currClass = StudentManager.classList[0]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        classPicker.delegate = self
        classPicker.dataSource = self
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StudentManager.classList.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StudentManager.classList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currClass = StudentManager.classList[row]
    }
    
    func enableViewForEditting() {
        btnSave.setTitle("Save", for: .normal)
        edFirstNam.isUserInteractionEnabled = true
        edLastName.isUserInteractionEnabled = true
        classPicker.isUserInteractionEnabled = true
        edOtherInfo.isUserInteractionEnabled = true
        datePicker.isUserInteractionEnabled = true
        
        isEditting = true
    }
    
    func saveDataAndDismiss() {
        let myCalendar = Calendar(identifier: .gregorian)
        let birthDate = myCalendar.component(.day, from: datePicker.date)
        let birthMonth = myCalendar.component(.month, from: datePicker.date)
        let birthYear = myCalendar.component(.year, from: datePicker.date)
        let date = MyDate(day: birthDate, month: birthMonth, year: birthYear)
        
        currStudent = Student(firstName: edFirstNam.text!, lastName: edLastName.text!, dateOfBirth: date, myClass: currClass, otherInfo: edOtherInfo.text!)
        
        if delegate != nil {
            delegate?.saveData(student: currStudent!, studentIndex: studentIndex, mode: viewMode)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

