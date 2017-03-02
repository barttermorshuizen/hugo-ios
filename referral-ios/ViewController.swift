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
    @IBOutlet weak var mReferralReason: UITextView!
    @IBOutlet weak var mPatient: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var mOwner: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnTel: UIButton!
    @IBOutlet weak var lblVet: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblPatient: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    
    var radioButtonController: SSRadioButtonsController?
    var referral: Referral!
    
    let accentedColor : UIColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
    let normalColor : UIColor = UIColor.darkGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        referral = Referral();
        
        radioButtonController = SSRadioButtonsController(buttons: btnEmail, btnTel)
        radioButtonController!.delegate = self

       
        
        mVet.addTarget(self, action: #selector(vetClick), for: UIControlEvents.touchDown)
        mPatient.addTarget(self, action: #selector(patientClick), for: UIControlEvents.touchDown)
        mOwner.addTarget(self, action: #selector(ownerClick), for: UIControlEvents.touchDown)
        btnSend.addTarget(self, action: #selector(sendClick), for: UIControlEvents.touchDown)
        
        setBorder(mVet)
        setBorder(mReferralReason)
        setBorder(mPatient)
        setBorder(mOwner)
        
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    

    func textViewDidChange(_ textView: UITextView) {
        colorLabelsWhenEmpty()
    }
    
    func didSelectButton(_ aButton: UIButton?) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
    }
    

    @IBAction func phoneClick(_ sender: UIBarButtonItem) {
        let busPhone = "0204081408"
        Call.callNumber(phoneNumber: busPhone)
    }
    
    func vetClick(textField: UITextField) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
    }
    func patientClick(textField: UITextField) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
    }
    func ownerClick(textField: UITextField) {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
    }
    
    
    @IBAction func clearClick(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Wissen", message: "Het gehele verwijsformulier wordt gewist. Weet je het zeker?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (action: UIAlertAction!) in
            self.clear()
            //close keybard if reason was first responder
            if (self.mReferralReason.isFirstResponder){
                self.mReferralReason.resignFirstResponder()
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Nee", style: .cancel, handler: { (action: UIAlertAction!) in
            // no action
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func mail() {
        //close keybard if reason was first responder
        if (mReferralReason.isFirstResponder){
            mReferralReason.resignFirstResponder()
        }
        viewToModel()
        // check before mail
        let msg : String = referral.validateComplete()
        if (msg == "Ok") {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["bart@moreawesome.co"])
                if (referral!.mOwnerEmail != nil && !(referral!.mOwnerEmail!.isEmpty)){
                    mail.setCcRecipients([referral!.mOwnerEmail!])
                }
                mail.setSubject("Verwijzing ten behoeve van " + referral!.getOwnerName()!);
                mail.setMessageBody(referral!.toMessage(), isHTML: false)
                
                // Create a destination URL.
                var attachmentContents:String=""
                let fileName = "5678909878"
                
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: referral.toJson(), options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    attachmentContents =  String(data: jsonData, encoding: String.Encoding.utf8)!
                } catch {
                    print(error.localizedDescription)
                }
                
                let url = stringToFile(attachmentContents,toFile: fileName);
        
                if let fileData = NSData (contentsOf: url)
                    
                    {
                        mail.addAttachmentData(fileData as Data, mimeType: "application/prs.hugo", fileName:fileName + ".hugo")
                    }
                present(mail, animated: true)
            } else {
                let alert = UIAlertController(title: "Waarschuwing", message: "E-mail kan niet worden verstuurd", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Sluit", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
       }
        else {
            // validation is not ok
            let validationAlert = UIAlertController(title: "Validatie", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            
            validationAlert.addAction(UIAlertAction(title: "Sluiten", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            present(validationAlert, animated: true, completion: nil)            
            
        }
    }
    
func stringToFile(_ string:String, toFile fileName:String) -> URL {
    // stores the given string in the fileName.hugo path in the temporary directory
    let fileExtension="hugo"
    let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
    let targetURL = tempDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
    //writing
    do {
        try string.write(to: targetURL, atomically: false, encoding: String.Encoding.utf8)
    }
    catch {
        
    }
    return targetURL
}

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func sendClick(textField: UITextField) {
        mail()
    }
    
    func setButtonTitle(_ modelValue : String?, for button : UIButton, empty emptyTitle : String){
        
        if (modelValue == nil || (modelValue != nil && modelValue!.isEmpty)){
            button.setTitle(emptyTitle, for: UIControlState.normal)
        }
        else {
           button.setTitle(modelValue!, for: UIControlState.normal)
        }
    }
    
    
    func colorVetLabelWhenEmpty(){
        
        let vetEmpty : Bool = (referral!.getVetPractice() == nil || referral!.getVetPractice()!.isEmpty)

        if (vetEmpty){
            lblVet.textColor = accentedColor
        }
        else {
            lblVet.textColor = normalColor
        }
    }
    
    func colorReasonLabelWhenEmpty(){
        let text : String = mReferralReason.text
        if (text.isEmpty){
            lblReason.textColor = accentedColor
        }
        else {
            lblReason.textColor = normalColor
        }
    }
    
    func colorPatientLabelWhenEmpty(){
        if (referral!.getPatientType() == nil || referral!.getPatientType()!.isEmpty){
            lblPatient.textColor = accentedColor
        }
        else {
            lblPatient.textColor = normalColor
        }
    }
    
    func colorOwnerLabelWhenEmpty(){
        
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

    func colorLabelsWhenEmpty(){
        colorVetLabelWhenEmpty();
        colorReasonLabelWhenEmpty();
        colorPatientLabelWhenEmpty();
        colorOwnerLabelWhenEmpty();
    }

    func setBorder(_ view:UIView){
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
    }
    
    func modelToView(){
        // copies the model in the view
    
        // vet
        setButtonTitle(referral.getVetPractice(), for: mVet, empty: "Dierenarts...")
        
        
        // reason
        mReferralReason.text = referral.getReason();
        
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

