//
//  VetController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class VetController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mEditTextName: UITextField!
    @IBOutlet weak var mEditTextVetPractice: UITextField!
    @IBOutlet weak var mEditTextVetPlace: UITextField!
    @IBOutlet weak var mEditTextVetEmail: UITextField!
    @IBOutlet weak var lblVetPractice: UILabel!
    @IBOutlet weak var lblVetEmail: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
    var referral : Referral?
    
    
    @objc var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Dierenarts"
        
        referral = Referral()
        
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
    
    
    @IBAction func practiceChanged(_ sender: Any) {
        colorLabelsWhenEmpty()
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        colorLabelsWhenEmpty()
    }
    
    
    @objc func colorLabelWhenEmpty(_ label:UILabel, _ editText:UITextField){
        if (editText.text!.isEmpty){
            // set label text to accent color
            label.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
        }
        else {
            // set label in gray color
            label.textColor = UIColor.darkGray
        }
    }
    
    
    @objc func colorLabelsWhenEmpty(){
        colorLabelWhenEmpty(lblVetPractice,mEditTextVetPractice);
        colorLabelWhenEmpty(lblVetEmail,mEditTextVetEmail);
    }
    
    
    @IBAction func phoneClicked(_ sender: Any) {
        let busPhone = "0203080750"
        Call.callNumber(phoneNumber: busPhone)
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        referral!.clearVet()
        referral!.store();
        modelToView();
    }
    
    @IBAction func okClicked(_ sender: Any) {
            _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func modelToView(){
        // copies the model in the view
        mEditTextName.text = referral!.getName()
        mEditTextVetPractice.text = referral!.getVetPractice()
        mEditTextVetPlace.text = referral!.getVetPlace()
        mEditTextVetEmail.text = referral!.getVetEmail()
        colorLabelsWhenEmpty()
    }
    
    @objc func viewToModel() {
        // store the vet, place and name preferences to the model.
        referral!.setName(name: mEditTextName.text)
        referral!.setVetPractice(vetPractice: mEditTextVetPractice.text)
        referral!.setVetPlace(vetPlace: mEditTextVetPlace.text)
        referral!.setVetEmail(vetEmail: mEditTextVetEmail.text)
        referral!.store();
    }
}
