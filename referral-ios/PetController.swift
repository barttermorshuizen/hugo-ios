//
//  PetController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 22/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class PetController : UIViewController, UITextFieldDelegate, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var mEditTextPetName: UITextField!
    @IBOutlet weak var mEditTextPatientType: UITextField!
    @IBOutlet weak var mEditTextPatientRace: UITextField!
    @IBOutlet weak var mEditTextPatientDoB: UITextField!
    @IBOutlet weak var mRadioButtonGenderM: SSRadioButton!
    @IBOutlet weak var mRadioButtonGenderMG: SSRadioButton!
    @IBOutlet weak var mRadioButtonGenderV: SSRadioButton!
    @IBOutlet weak var mRadioButtonGenderVG: SSRadioButton!
    @IBOutlet weak var mRadioButtonGenderO: SSRadioButton!
    @IBOutlet weak var lblPatientType: UILabel!
    
    var referral : Referral?
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Patient"
        
        radioButtonController = SSRadioButtonsController(buttons: mRadioButtonGenderM, mRadioButtonGenderMG, mRadioButtonGenderV, mRadioButtonGenderVG, mRadioButtonGenderO)
        radioButtonController!.delegate = self
        
        referral = Referral();
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func didSelectButton(_ aButton: UIButton?) {
        //close keyboard
        if (mEditTextPetName.isFirstResponder){
            mEditTextPetName.resignFirstResponder()
        }
        if (mEditTextPatientType.isFirstResponder){
            mEditTextPatientType.resignFirstResponder()
        }
        if (mEditTextPatientRace.isFirstResponder){
            mEditTextPatientRace.resignFirstResponder()
        }
        if (mEditTextPatientDoB.isFirstResponder){
            mEditTextPatientDoB.resignFirstResponder()
        }
    }
    
    @IBAction func patientTypeChanged(_ sender: Any) {
        colorLabelsWhenEmpty()
    }
    
    func colorLabelWhenEmpty(_ label:UILabel, _ editText:UITextField){
        if (editText.text!.isEmpty){
            // set label text to accent color
            label.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
        }
        else {
            // set label in gray color
            label.textColor = UIColor.darkGray
        }
    }
    
    func colorLabelsWhenEmpty(){
        colorLabelWhenEmpty(lblPatientType,mEditTextPatientType);
    }

    
    func modelToView(){
        // copies the model in the view
        mEditTextPetName.text = referral!.getPatientName()
        mEditTextPatientType.text = referral!.getPatientType()
        mEditTextPatientRace.text = referral!.getPatientName()
        mEditTextPatientDoB.text = referral!.getPatientName()
        
        if (referral!.getPatientGender() != nil){
            let gender : String = referral!.getPatientGender()!
            
            switch gender {
            case "M":
                radioButtonController!.pressed(mRadioButtonGenderM)
            case "MG":
                radioButtonController!.pressed(mRadioButtonGenderMG)
            case "V":
                radioButtonController!.pressed(mRadioButtonGenderV)
            case "VG":
                radioButtonController!.pressed(mRadioButtonGenderVG)
            case "O":
                radioButtonController?.pressed(mRadioButtonGenderO)
            default: break
            }
        }
        
        colorLabelsWhenEmpty()
    }
    
    func viewToModel() {
        referral!.setPatientName(patientName: mEditTextPetName.text)
        referral!.setPatientType(patientType: mEditTextPatientType.text)
        referral!.setPatienRace(patienRace: mEditTextPatientRace.text)
        referral?.setPatientDoB(patientDoB: mEditTextPatientDoB.text)
        
        let currentButton = radioButtonController!.selectedButton()
        if (currentButton == mRadioButtonGenderM){
            referral!.setPatientGender(patientGender: "M")
        }
        else if (currentButton == mRadioButtonGenderMG){
            referral!.setPatientGender(patientGender: "MG")
        }
        else if (currentButton == mRadioButtonGenderV){
            referral!.setPatientGender(patientGender: "V")
        }
        else if (currentButton == mRadioButtonGenderVG){
            referral!.setPatientGender(patientGender: "VG")
        }
        else if (currentButton == mRadioButtonGenderO){
            referral!.setPatientGender(patientGender: "O")
        }
        
        referral!.store();
    }
}
