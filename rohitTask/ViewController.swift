//
//  ViewController.swift
//  rohitTask
//
//  Created by Vinayak Balaji Tuptewar on 10/10/20.
//  Copyright © 2020 Vinayak Balaji Tuptewar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var apartmenttf: UITextField!
    @IBOutlet weak var apartmentNametf: UITextField!
    @IBOutlet weak var bhkTypeTf: UITextField!
    @IBOutlet weak var floortf: UITextField!
    @IBOutlet weak var propertyAgetf: UITextField!
    @IBOutlet weak var propertySizetf: UITextField!
    @IBOutlet weak var balconttf: UITextField!
    @IBOutlet weak var facingtf: UITextField!
    @IBOutlet weak var prefferedTenant: UITextField!
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var viewOnScrollV: UIView!
    @IBOutlet weak var customViewHeight: NSLayoutConstraint!

    

    var customview = UIView()
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    var textfield = UITextField()
    var pickerview = UIPickerView()
    var arrData = [[String]]()
    
    var isOpenCustomview:Bool = false
    var customviewBottomAnchor:NSLayoutConstraint!
    var activetextfield = UITextField()
    var activevlue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAndSetupCustomview()
        loadAndSetupTextFieldAndPickerView()
        setButtonToRightSideOfTextField()
        
        arrData = [[]]
        
        apartmenttf.delegate = self
        apartmentNametf.delegate = self
        bhkTypeTf.delegate = self
        floortf.delegate = self
        propertyAgetf.delegate = self
        propertySizetf.delegate = self
        facingtf.delegate = self
        prefferedTenant.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.arrData.removeAll()
        
        switch textField {
        case self.apartmenttf:
            self.textfield.text = "Select Apartment Type"
            isOpenCustomview = true
            self.arrData.append(["Apartment","Independent house/villa","Gated community villa"])
            activetextfield = self.apartmenttf
        case self.apartmentNametf:
            self.textfield.text = "Select Apartment Name"
            isOpenCustomview = true
            self.arrData.append(["a","b","c","d","e"])
            activetextfield = self.apartmentNametf
        case self.bhkTypeTf:
            self.textfield.text = "Select BHK Type"
            isOpenCustomview = true
            self.arrData.append(["1 Rk","1 Bhk","2 Bhk","3 Bhk","4 Bhk"])
            activetextfield = self.bhkTypeTf
        case self.floortf:
            self.textfield.text = "Select Floor"
            isOpenCustomview = true
            self.arrData.append(["1 floor","2 floor","3 floor","4 floor","5 floor","6 floor","7 floor","8 floor"])
            activetextfield = self.floortf
        default:
            print("another selected")
            isOpenCustomview = false
            self.arrData.append([])
        }

        if isOpenCustomview{
            UIView.animate(withDuration: 1, delay: 0, options: .transitionCrossDissolve, animations: {
                self.customviewBottomAnchor.isActive = false
                self.customviewBottomAnchor = self.customview.bottomAnchor.constraint(equalTo: self.saveAndContinueBtn.topAnchor, constant: -8)
                self.customviewBottomAnchor.isActive = true
                self.view.layoutIfNeeded()
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 1, delay: 0, options: .transitionCrossDissolve, animations: {
                self.customviewBottomAnchor.isActive = false
                self.customviewBottomAnchor = self.customview.bottomAnchor.constraint(equalTo: self.saveAndContinueBtn.topAnchor, constant: 250)
                self.customviewBottomAnchor.isActive = true
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        self.pickerview.reloadAllComponents()
        
    }
    
    
    
    
    func loadAndSetupCustomview(){
        customview.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        self.view.addSubview(customview)
        
        customview.translatesAutoresizingMaskIntoConstraints = false
        self.customviewBottomAnchor = customview.bottomAnchor.constraint(equalTo: saveAndContinueBtn.topAnchor, constant: 250)
        self.customviewBottomAnchor.isActive = true
        customview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        customview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        customview.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func loadAndSetupTextFieldAndPickerView(){
        textfield.backgroundColor = .lightGray
        textfield.textAlignment = .center
        self.customview.addSubview(textfield)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.topAnchor.constraint(equalTo: self.customview.topAnchor, constant: 0).isActive = true
        textfield.leadingAnchor.constraint(equalTo: self.customview.leadingAnchor, constant: 0).isActive = true
        textfield.trailingAnchor.constraint(equalTo: self.customview.trailingAnchor, constant: 0).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        
        pickerview.delegate = self
        pickerview.dataSource = self
        self.customview.addSubview(pickerview)
        pickerview.translatesAutoresizingMaskIntoConstraints = false
        pickerview.topAnchor.constraint(equalTo: self.textfield.bottomAnchor, constant: 8).isActive = true
        pickerview.leadingAnchor.constraint(equalTo: self.customview.leadingAnchor, constant: 8).isActive = true
        pickerview.trailingAnchor.constraint(equalTo: self.customview.trailingAnchor, constant: 8).isActive = true
        pickerview.bottomAnchor.constraint(equalTo: self.customview.bottomAnchor, constant: -8).isActive = true
        
    }
    
    func setButtonToRightSideOfTextField(){
            var doneBtn = UIButton(type: .custom)
            doneBtn.setTitle("Done", for: .normal)
            doneBtn.setTitleColor(.blue, for: .normal)
            doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
            
            textfield.rightViewMode = .always
            textfield.rightView = doneBtn
        }
    
    @objc func doneBtnClick(_ sender:UIButton){
            print("Done click")
        activetextfield.text = activevlue
        }
    
    
    
}
extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrData[0].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrData[0][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(self.arrData[0][row])
        self.textfield.text = "\(self.arrData[0][row])"
        activevlue = self.arrData[0][row]
    }
}
    
    
