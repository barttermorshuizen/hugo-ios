//
//  TransferController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 29/03/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//


import UIKit
import MailgunSwift


class TransferController: UIViewController {
    
    @IBOutlet weak var progressText: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var referral : Referral?
    var mailSuccess : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Verwijs naar Hugo"
        
        referral = Referral()
        mailSuccess = false
        
        progressText.text = "De verwijzing wordt verstuurd..."
        progressBar.setProgress(0.0, animated: true)
        
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        var emailHugo : String = ""
        var apiKey : String = ""
        var clientDomain : String = ""
        
        if let dict = myDict {
            // Use your dict here
            emailHugo = dict.object(forKey: "email_hugo") as! String
            apiKey = dict.object(forKey: "mailgun_api_key") as! String
            clientDomain = dict.object(forKey: "mailgun_client_domain") as! String
        }
        
        if (isOnline()){
            progressBar.setProgress(0.5, animated: true)
            // send mail
            
            let mailgun = Mailgun(apiKey: apiKey, domain: clientDomain)
            
            let message = MailgunMessage(from:(referral?.getVetEmail())!,
                                         to:emailHugo,
                                         message:"Verwijzing ten behoeve van " + (referral?.getOwnerName())!,
                                         body:"")
            message.html = referral?.toMessage()

            if (referral?.getIsRecordedReason())!{
                let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
                
                do {
                    let d = try Data.init(contentsOf: audioFilename)
                    message.add(attachment: d, named: "recording.m4a", type: "audio/m4a")
                }
                catch {
                    debugPrint("Error attaching recording",error)
                }
            }
            
            mailgun.send(message: message) { result in
                switch result {
                case .success(let messageId):do {
                    debugPrint("Succesfull sending: ",messageId)
                    self.progressText.text="De verwijzing is verstuurd. \nHugo neemt snel contact op met de eigenaar voor een afspraak. \n\nBedankt voor de verwijzing! \n\nHugo"
                    self.mailSuccess = true
                    }
                case .failure (let error): do {
                    debugPrint("Error sending: ",error);
                    self.progressText.text="De verwijzing is niet verstuurd naar Hugo wegens een technisch probleem:" + error.localizedDescription + "\nNeem telefonisch contact op met Hugo om de verwijzing door te geven.\n\nHugo";
                    self.mailSuccess = false
                    }
                }
                self.progressBar.setProgress(1.0, animated: true)
            }
        }
        else {
            mailSuccess = false
            progressBar.isHidden = true
            progressText.text = "De verwijzing is niet verstuurd. \nEr is geen internetconnectie. Zorg voor internetconnectie en probeer het nog eens! \nOf neem telefonisch contact op met Hugo om de verwijzing door te geven. \n\nHugo"
        }
        
    }
    
    @IBAction func okClick(_ sender: Any) {
        if (mailSuccess!){
            referral?.clear()
            referral?.store()
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func isOnline() -> Bool {
        let reachability: Reachability = Reachability.init()!
        let networkStatus:Int = reachability.currentReachabilityStatus.hashValue
        return networkStatus != 0
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
