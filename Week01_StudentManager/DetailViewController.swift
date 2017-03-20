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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        if mode == ListStudentViewController.MODE_ADD {
            myStudent = Student(firstName: edFirstNam.text!, lastName: edLastName.text!, dateOfBirth: MyDate(), myClass: MyClass(), otherInfo: edOtherInfo.text!)
            
            if delegate != nil {
                delegate?.saveData(student: myStudent!, studentIndex: studentIndex, mode: mode)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            if isEditting {
                myStudent = Student(firstName: edFirstNam.text!, lastName: edLastName.text!, dateOfBirth: MyDate(), myClass: MyClass(), otherInfo: edOtherInfo.text!)
                
                if delegate != nil {
                    delegate?.saveData(student: myStudent!, studentIndex: studentIndex, mode: mode)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                btnSave.setTitle("Save", for: .normal)
                edFirstNam.isUserInteractionEnabled = true
                edLastName.isUserInteractionEnabled = true
                classPicker.isUserInteractionEnabled = true
                edOtherInfo.isUserInteractionEnabled = true
                datePicker.isUserInteractionEnabled = true
                
                isEditting = true
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (mode == ListStudentViewController.MODE_EDIT)
        {
            edFirstNam.text = myStudent!.firstName
            edLastName.text = myStudent!.lastName
            edOtherInfo.text = myStudent!.otherInfo
            classPicker.selectRow(Int((myStudent?.myClass.id)!)! - 1, inComponent: 0, animated: true)
            btnSave.setTitle("Edit", for: .normal)
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

