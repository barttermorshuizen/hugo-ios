//
//  ViewController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, SSRadioButtonControllerDelegate, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var mVet: UIButton!
    @IBOutlet weak var mReferralReason: UITextView!
    @IBOutlet weak var mPatient: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var mOwner: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnTel: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    var referral: Referral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        referral = Referral();
        
        radioButtonController = SSRadioButtonsController(buttons: btnEmail, btnTel)
        radioButtonController!.delegate = self

       
        
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    

    func didSelectButton(_ aButton: UIButton?) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func phoneClick(_ sender: UIBarButtonItem) {
        let busPhone = "31204081408"
        callNumber(phoneNumber: busPhone)
    }
    
    func vetClick(textField: UITextField) {
        
    }
    func patientClick(textField: UITextField) {
        
    }
    func ownerClick(textField: UITextField) {
    }
    func clearClick(textField: UITextField) {
        clear()
    
    }
    
    func mail() {
        viewToModel()
    
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["bart@moreawesome.co"])
            if (referral!.mOwnerEmail != nil && !(referral!.mOwnerEmail!.isEmpty)){
                mail.setCcRecipients([referral!.mOwnerEmail!])
            }
            mail.setSubject("Verwijzing")
            mail.setMessageBody(referral!.toMessage(), isHTML: false)
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Waarschuwing", message: "E-mail kan niet worden verstuurd", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Sluit", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func sendClick(textField: UITextField) {
        mail()
    }
    
    func setButtonTitle(_ modelValue : String?, for button : UIButton){
        let emptyTitle : String = "Tap om te veranderen..."
        if (modelValue == nil || (modelValue != nil && modelValue!.isEmpty)){
            button.setTitle(emptyTitle, for: UIControlState.normal)
        }
        else {
           button.setTitle(modelValue!, for: UIControlState.normal)
        }
    }
    
    func modelToView(){
        // copies the model in the view
    
        // vet
        setButtonTitle(referral.getVetPractice(), for: mVet)
        
        
        // reason
        mReferralReason.text = referral.getReason();
        
        // patient
        setButtonTitle(referral.getPatientName(), for: mPatient)
        
        // owner
        setButtonTitle(referral.getOwnerName(), for: mOwner)
        
        // contact
        if (referral.getContactByEmail()!){
            radioButtonController!.pressed(btnEmail)
        }
        else {
            radioButtonController!.pressed(btnTel)
        }
        
    }
    
    func viewToModel(){
        // only pushes the reason and contact preference to the model. It is assumed that the other activities sync to the model when they close
        referral.setReason(reason: mReferralReason.text)
        // todo button value
        
       
        let currentButton = radioButtonController!.selectedButton()
        if (currentButton != nil && currentButton == btnTel) {
            referral.setContactByEmail(contactByEmail: false)
        }
        else {
            referral.setContactByEmail(contactByEmail: true)
        }

        referral.store()
    }
    
    func clear(){
        referral.clear()
        referral.store();
        modelToView();
    }
}

