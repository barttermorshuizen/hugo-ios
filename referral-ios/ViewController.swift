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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

