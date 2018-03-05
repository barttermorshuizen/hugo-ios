//
//  ViewController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController, SSRadioButtonControllerDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate {


    
    @IBOutlet weak var mVet: UIButton!
    @IBOutlet weak var mReason: UIButton!
    @IBOutlet weak var mPatient: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var mOwner: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnTel: UIButton!
    @IBOutlet weak var lblVet: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblPatient: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    
    @objc var radioButtonController: SSRadioButtonsController?
    
    var referral: Referral!
    
   
    
    @objc let accentedColor : UIColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
    @objc let normalColor : UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        referral = Referral();
        
        radioButtonController = SSRadioButtonsController(buttons: btnEmail, btnTel)
        radioButtonController!.delegate = self
        
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0, green: 174/255, blue: 239/255, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.isTranslucent = false
        
        self.automaticallyAdjustsScrollViewInsets = false
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
    

    func textViewDidChange(_ textView: UITextView) {
        colorLabelsWhenEmpty()
    }
    

    @IBAction func phoneClick(_ sender: UIBarButtonItem) {
        let busPhone = "0203080750"
        Call.callNumber(phoneNumber: busPhone)
    }
    
   
    
    @IBAction func clearClick(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Wissen", message: "Het gehele verwijsformulier wordt gewist. Weet je het zeker?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (action: UIAlertAction!) in
            self.clear()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Nee", style: .cancel, handler: { (action: UIAlertAction!) in
            // no action
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    

    
    @IBAction func sendClick(_ sender: Any) {
        
        viewToModel()
        // check before moving to sending mail
        let msg : String = referral.validateComplete()
        if (msg == "Ok") {
            let transferController = self.storyboard?.instantiateViewController(withIdentifier: "TransferController") as! TransferController
            self.navigationController?.pushViewController(transferController, animated: true)
        }
        else {
            // validation is not ok
            let validationAlert = UIAlertController(title: "Validatie", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            
            validationAlert.addAction(UIAlertAction(title: "Sluiten", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            present(validationAlert, animated: true, completion: nil)
        }
    }
    
    
    @objc func setButtonTitle(_ modelValue : String?, for button : UIButton, empty emptyTitle : String){
        
        if (modelValue == nil || (modelValue != nil && modelValue!.isEmpty)){
            button.setTitle(emptyTitle, for: UIControlState.normal)
        }
        else {
           button.setTitle(modelValue!, for: UIControlState.normal)
        }
    }
    
    
    @objc func colorVetLabelWhenEmpty(){
        
        let vetEmpty : Bool = (referral!.getVetPractice() == nil || referral!.getVetPractice()!.isEmpty)

        if (vetEmpty){
            lblVet.textColor = accentedColor
        }
        else {
            lblVet.textColor = normalColor
        }
    }
    
    @objc func colorReasonLabelWhenEmpty(){
        let reasonEmpty : Bool = ((referral!.getReason() == nil || referral.getReason() == "") && !referral!.getIsRecordedReason())
        
        if (reasonEmpty){
            lblReason.textColor = accentedColor
        }
        else {
            lblReason.textColor = normalColor
        }
    }
    
    @objc func colorPatientLabelWhenEmpty(){
        if (referral!.getPatientType() == nil || referral!.getPatientType()!.isEmpty){
            lblPatient.textColor = accentedColor
        }
        else {
            lblPatient.textColor = normalColor
        }
    }
    
    @objc func colorOwnerLabelWhenEmpty(){
        
        let ownerEmailEmpty : Bool = (referral!.getOwnerEmail() == nil || referral!.getOwnerEmail()!.isEmpty)
        let ownerTelEmpty : Bool = (referral!.getOwnerTel() == nil || referral!.getOwnerTel()!.isEmpty)
        let ownerNameEmpty :Bool = (referral!.getOwnerName() == nil || referral!.getOwnerName()!.isEmpty)
        
        
        if ((ownerEmailEmpty && ownerTelEmpty)||ownerNameEmpty){
            lblOwner.textColor = accentedColor
        }
        else {
            lblOwner.textColor = normalColor
        }
    }

    @objc func colorLabelsWhenEmpty(){
        colorVetLabelWhenEmpty();
        colorReasonLabelWhenEmpty();
        colorPatientLabelWhenEmpty();
        colorOwnerLabelWhenEmpty();
    }

    @objc func setBorder(_ view:UIView){
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
    }
    
    @objc func modelToView(){
        // copies the model in the view
    
        // vet
        setButtonTitle(referral.getVetPractice(), for: mVet, empty: "Dierenarts...")
        
        // reason
        if (referral.getIsRecordedReason()){
            // recorded reason
            setButtonTitle("Opgenomen reden", for: mReason, empty: "")
        }
        else {
            setButtonTitle(referral.getReason(), for: mReason, empty: "Reden...")
        }
        // patient
        setButtonTitle(referral.getPatientType(), for: mPatient, empty: "Patient...")
        
        // owner
        setButtonTitle(referral.getOwnerName(), for: mOwner, empty: "Eigenaar...")
        
        // contact
        if (referral.getContactByEmail()){
            radioButtonController!.pressed(btnEmail)
        }
        else {
            radioButtonController!.pressed(btnTel)
        }
        
        colorLabelsWhenEmpty()
    }
    
    func didSelectButton(_ aButton: UIButton?) {
        //
    }
    
    @objc func viewToModel(){
        // only pushes the contact preference to the model. It is assumed that the other activities sync to the model when they close
       
        let currentButton = radioButtonController!.selectedButton()
        if (currentButton != nil && currentButton == btnTel) {
            referral.setContactByEmail(contactByEmail: false)
        }
        else {
            referral.setContactByEmail(contactByEmail: true)
        }

        referral.store()
    }
    
    @objc func clear(){
        referral.clear()
        referral.store();
        modelToView();
    }
    

}

