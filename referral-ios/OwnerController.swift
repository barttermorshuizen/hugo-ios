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
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var lblOwnerEmail: UILabel!
    @IBOutlet weak var lblOwnerTel: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
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
    @IBAction func ownerNameChanged(_ sender: Any) {
        colorLabelsWhenEmpty()
    }
    
    @IBAction func ownerEmailChanged(_ sender: Any) {
        colorLabelsWhenEmpty()
    }
    
    
    @IBAction func ownerTelChanged(_ sender: Any) {
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
        colorLabelWhenEmpty(lblOwnerName,mEditTextOwnerName);
        // when either email or tel is filled, both can be light gray. If both empty, both accent color
        if (!mEditTextOwnerEmail.text!.isEmpty || !mEditTextOwnerTel.text!.isEmpty){
            lblOwnerEmail.textColor = UIColor.darkGray
            lblOwnerTel.textColor = UIColor.darkGray
        }
        else {
            lblOwnerEmail.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
            lblOwnerTel.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
        }
    }

    @IBAction func phoneClicked(_ sender: Any) {
        let busPhone = "0204081408"
        Call.callNumber(phoneNumber: busPhone)
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        referral!.clearOwner()
        referral!.store();
        modelToView();
    }
    
    @IBAction func okClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func modelToView(){
        // copies the model in the view
        //mEditTextName.text = referral!.getName();
        mEditTextOwnerName.text = referral!.getOwnerName()
        mEditTextOwnerEmail.text = referral!.getOwnerEmail()
        mEditTextOwnerTel.text = referral!.getOwnerTel()
        colorLabelsWhenEmpty()
    }
    
    @objc func viewToModel() {
        referral!.setOwnerName(ownerName: mEditTextOwnerName.text)
        referral!.setOwnerEmail(ownerEmail: mEditTextOwnerEmail.text)
        referral!.setOwnerTel(ownerTel: mEditTextOwnerTel.text)
        referral!.store();
    }

}
