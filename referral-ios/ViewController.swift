//
//  ViewController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var contactPicker: UIPickerView!
    @IBOutlet weak var mVet: UIButton!
    @IBOutlet weak var mReferralReason: UITextView!
    @IBOutlet weak var mPatient: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var mOwner: UIButton!
    
    var pickerData: [String] = [String]()
    
    var referral: Referral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        referral = Referral();
        
        // Do any additional setup after loading the view, typically from a nib.
        // Input data into the Array:
        pickerData = ["E-Mail", "Telefonisch"]
        self.contactPicker.delegate = self
        self.contactPicker.dataSource = self
        
        mVet.addTarget(self, action: #selector(vetClick), for: UIControlEvents.touchDown)
        mPatient.addTarget(self, action: #selector(patientClick), for: UIControlEvents.touchDown)
        mOwner.addTarget(self, action: #selector(ownerClick), for: UIControlEvents.touchDown)
        btnClear.addTarget(self, action: #selector(clearClick), for: UIControlEvents.touchDown)
        btnSend.addTarget(self, action: #selector(sendClick), for: UIControlEvents.touchDown)
        
        modelToView()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewToModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        referral = Referral();
        modelToView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func vetClick(textField: UITextField) {
        
    }
    func patientClick(textField: UITextField) {
        
    }
    func ownerClick(textField: UITextField) {
    }
    func clearClick(textField: UITextField) {
    
    }
    func sendClick(textField: UITextField) {
    
    }
    
    func modelToView(){
        // copies the model in the view
        mVet.setTitle(referral.getVetPractice(), for: UIControlState.normal)
        mReferralReason.text = referral.getReason();
        // todo patient
        var patientName : String
        if (referral.getPatientName() != nil){
            patientName = referral.getPatientName()!
        }
        else {
            patientName = ""
        }
        if (referral.getPatientType() != nil && !(referral.getPatientType()!.isEmpty)) {
            patientName = patientName + " (" + referral.getPatientType()! + ")"
        }
        
        mPatient.setTitle(patientName, for: UIControlState.normal)
        
        mOwner.setTitle(referral.getOwnerName(), for: UIControlState.normal)
        // todo spinner value
        if (referral.getContactByEmail() != nil && referral.getContactByEmail()!){
            contactPicker.selectRow(0, inComponent: 0, animated: true)
        }
        else {
            contactPicker.selectRow(1, inComponent: 0, animated: true)
        }
        
    }
    
    func viewToModel(){
    // only pushes the reason and contact preference to the model. It is assumed that the other activities sync to the model when they close
    referral.setReason(reason: mReferralReason.text)
        if (contactPicker.selectedRow(inComponent:0)==0){
            referral.setContactByEmail(contactByEmail: true)
        }
        else {
            referral.setContactByEmail(contactByEmail: false)
        }
        referral.store()
    }
}

