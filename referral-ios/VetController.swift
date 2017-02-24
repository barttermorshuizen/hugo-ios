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
    @IBOutlet weak var lblVetPractice: UILabel!
    
    var referral : Referral?
    
    
    var pickerData: [String] = [String]()
    
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
        colorLabelsWhenEmpty();
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
        colorLabelWhenEmpty(lblVetPractice,mEditTextVetPractice);
    }
    
    
    @IBAction func phoneClicked(_ sender: Any) {
        let busPhone = "0204081408"
        Call.callNumber(phoneNumber: busPhone)
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        referral!.clearVet()
        referral!.store();
        modelToView();
    }
    
    
    func modelToView(){
        // copies the model in the view
        mEditTextName.text = referral!.getName()
        mEditTextVetPractice.text = referral!.getVetPractice()
        mEditTextVetPlace.text = referral!.getVetPlace()
        colorLabelsWhenEmpty()
    }
    
    func viewToModel() {
        // store the vet, place and name preferences to the model.
        referral!.setName(name: mEditTextName.text)
        referral!.setVetPractice(vetPractice: mEditTextVetPractice.text)
        referral?.setVetPlace(vetPlace: mEditTextVetPlace.text)
        referral!.store();
    }
}
