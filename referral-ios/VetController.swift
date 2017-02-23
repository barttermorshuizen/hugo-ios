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
    
    func modelToView(){
        // copies the model in the view
        mEditTextName.text = referral!.getName()
        mEditTextVetPractice.text = referral!.getVetPractice()
        mEditTextVetPlace.text = referral!.getVetPlace()
    }
    
    func viewToModel() {
        // store the vet, place and name preferences to the model.
        referral!.setName(name: mEditTextName.text)
        referral!.setVetPractice(vetPractice: mEditTextVetPractice.text)
        referral?.setVetPlace(vetPlace: mEditTextVetPlace.text)
        referral!.store();
    }
}
