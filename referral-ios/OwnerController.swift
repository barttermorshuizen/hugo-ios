//
//  OwnerController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 22/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class OwnerController : UIViewController, UITextFieldDelegate {
    var referral : Referral?
    
    @IBOutlet weak var mEditTextOwnerName: UITextField!
    @IBOutlet weak var mEditTextOwnerEmail: UITextField!
    @IBOutlet weak var mEditTextOwnerTel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Eigenaar"
        
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
    
    func modelToView(){
        // copies the model in the view
        //mEditTextName.text = referral!.getName();
        mEditTextOwnerName.text = referral!.getOwnerName()
        mEditTextOwnerEmail.text = referral!.getOwnerEmail()
        mEditTextOwnerTel.text = referral!.getOwnerTel()        
    }
    
    func viewToModel() {
        referral!.setOwnerName(ownerName: mEditTextOwnerName.text)
        referral!.setOwnerEmail(ownerEmail: mEditTextOwnerEmail.text)
        referral!.setOwnerTel(ownerTel: mEditTextOwnerTel.text)
        referral!.store();
    }

}
