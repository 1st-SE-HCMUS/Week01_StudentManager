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
    
    var myStudent:Student?
    var myClass: MyClass = MyClass()
    var studentIndex: Int?
    var mode: Int?
    var isEditting:Bool = false
    
    weak var delegate : DetailVCDelegate?

    @IBOutlet weak var edFirstNam: UITextField!
    
    @IBOutlet weak var edLastName: UITextField!

    @IBOutlet weak var edOtherInfo: UITextField!
    
    @IBOutlet weak var classPicker: UIPickerView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        if mode == ListStudentViewController.MODE_ADD {
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (mode == ListStudentViewController.MODE_EDIT)
        {
            edFirstNam.text = myStudent!.firstName
            edLastName.text = myStudent!.lastName
            edOtherInfo.text = myStudent!.otherInfo
            let classIndex = (myStudent?.myClass.getIdNumber())! - 1
            classPicker.selectRow(classIndex, inComponent: 0, animated: true)
            myClass = myStudent!.myClass
            btnSave.setTitle("Edit", for: .normal)
        }
        else
        {
            enableViewForEditting()
            myClass = StudentManager.classList[0]
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
        myClass = StudentManager.classList[row]
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
        myStudent = Student(firstName: edFirstNam.text!, lastName: edLastName.text!, dateOfBirth: MyDate(), myClass: myClass, otherInfo: edOtherInfo.text!)
        
        if delegate != nil {
            delegate?.saveData(student: myStudent!, studentIndex: studentIndex, mode: mode)
        }
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

