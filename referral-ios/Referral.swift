//
//  Referral.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import Foundation

class Referral {
    
    var mName : String? // name of the referrer
    var mVetPractice : String? // name of the practice
    var mVetPlace : String? // place of the practice
    var mPatientName : String? // name of the patient
    var mPatientType : String? // type of patient (e.g. Dog, Cat)
    var mPatienRace : String? // race of the patient (e.g. Irish Setter)
    var mPatientDoB : String? // Date of birth of the patient
    var mPatientGender : String? // Gender of patient
    var mOwnerName : String? // name of the owner
    var mOwnerTel : String? // telephone number of the owner
    var mOwnerEmail : String?// email of the owner
    var mReason : String?
    var mContactByEmail : Bool
    
    func getName() -> String? {
        return mName
    }
    
    func setName(name:String?) {
        mName = name;
    }
    
    func getVetPractice() -> String?  {
        return mVetPractice
    }
    
    func setVetPractice(vetPractice: String?) {
        mVetPractice = vetPractice
    }
    
    func getVetPlace() -> String?  {
        return mVetPlace
    }
    
    func setVetPlace(vetPlace: String?) {
        mVetPlace = vetPlace
    }
    
    func getPatientName() -> String? {
    return mPatientName
    }
    
    func setPatientName( patientName : String?) {
        mPatientName = patientName
    }
    
    func getPatientType() -> String? {
    return mPatientType
    }
    
    func setPatientType(patientType : String?) {
        mPatientType = patientType
    }
    
    func getPatienRace() -> String? {
        return mPatienRace
    }
    
    func setPatienRace(patienRace : String?) {
        mPatienRace = patienRace
    }
    
    func getPatientDoB() -> String? {
        return mPatientDoB
    }
    
    func setPatientDoB(patientDoB : String?) {
        mPatientDoB = patientDoB;
    }
    
    func  getPatientGender() -> String? {
        return mPatientGender
    }
    
    func setPatientGender(patientGender : String?) {
        mPatientGender = patientGender
    }
    
    func getOwnerName() -> String? {
        return mOwnerName
    }
    
    func setOwnerName(ownerName : String?) {
        mOwnerName = ownerName
    }
    
    func getOwnerTel() -> String? {
        return mOwnerTel
    }
    
    func setOwnerTel(ownerTel : String?) {
        mOwnerTel = ownerTel
    }
    
    func  getOwnerEmail() -> String? {
    return mOwnerEmail
    }
    
    func setOwnerEmail(ownerEmail : String?) {
        mOwnerEmail = ownerEmail
    }
    
    func getReason() -> String? {
        return mReason
    }
    
    func setReason(reason : String?) {
        mReason = reason
    }
    
    func getContactByEmail() -> Bool {
        return mContactByEmail
    }
    
    func setContactByEmail(contactByEmail : Bool) {
        mContactByEmail = contactByEmail
    }
    
    init() {
        let defaults = UserDefaults.standard
        mName = defaults.string(forKey: "mName")
        mVetPractice = defaults.string(forKey: "mVetPractice")
        mVetPlace = defaults.string(forKey: "mVetPlace")
        mPatientName = defaults.string(forKey: "mPatientName")
        mPatientType = defaults.string(forKey: "mPatientType")
        mPatienRace = defaults.string(forKey: "mPatienRace")
        mPatientDoB = defaults.string(forKey: "mPatientDoB")
        mPatientGender = defaults.string(forKey: "mPatientGender")
        mOwnerName = defaults.string(forKey: "mOwnerName")
        mOwnerTel = defaults.string(forKey: "mOwnerTel")
        mOwnerEmail = defaults.string(forKey: "mOwnerEmail")
        mReason = defaults.string(forKey: "mReason")
        let contactByEmail = defaults.object(forKey: "mContactByEmail")
        if (contactByEmail != nil) {
            mContactByEmail = contactByEmail as! Bool
        }
        else {
            mContactByEmail = true // defaults to true
        }
    }
    
    init?(json: [String: Any]) {
        guard
            let name = json["name"] as? String,
            let vetpractice = json["vetpractice"] as? String,
            let vetplace = json["vetplace"] as? String,
            let patientname = json["patientname"] as? String,
            let patienttype = json["patienttype"] as? String,
            let patientrace = json["patientrace"] as? String,
            let patientdob = json["patientdob"] as? String,
            let patientgender = json["patientgender"] as? String,
            let ownername = json["ownername"] as? String,
            let ownertel = json["ownertel"] as? String,
            let owneremail = json["owneremail"] as? String,
            let reason = json["reason"] as? String,
            let contactbyemail = json["contactbyemail"] as? Bool
        else {
            return nil
        }
        
        mName = name
        mVetPractice = vetpractice
        mVetPlace = vetplace
        mPatientName = patientname
        mPatientType = patienttype
        mPatienRace = patientrace
        mPatientDoB = patientdob
        mPatientGender = patientgender
        mOwnerName = ownername
        mOwnerTel = ownertel
        mOwnerEmail = owneremail
        mReason = reason
        mContactByEmail = contactbyemail
        
    }
    
    func toJson() -> NSDictionary {
        let json:NSMutableDictionary = NSMutableDictionary()
        json.setValue(mName, forKey: "name")
        json.setValue(mVetPractice, forKey: "vetpractice")
        json.setValue(mVetPlace, forKey: "vetplace")
        json.setValue(mPatientName, forKey: "patientname")
        json.setValue(mPatientType, forKey: "patienttype")
        json.setValue(mPatienRace, forKey: "patientrace")
        json.setValue(mPatientDoB, forKey: "patientdob")
        json.setValue(mPatientGender, forKey: "patientgender")
        json.setValue(mOwnerName, forKey: "ownername")
        json.setValue(mOwnerTel, forKey: "ownertel")
        json.setValue(mOwnerEmail, forKey: "owneremail")
        json.setValue(mReason, forKey: "reason")
        json.setValue(mContactByEmail, forKey: "contactbyemail")
        return json
    }
    
    func store(){
    
        let defaults = UserDefaults.standard
        defaults.setValue(mName, forKey: "mName")
        defaults.setValue(mVetPractice, forKey: "mVetPractice")
        defaults.setValue(mVetPlace, forKey: "mVetPlace")
        defaults.setValue(mPatientName, forKey: "mPatientName")
        defaults.setValue(mPatientType, forKey: "mPatientType")
        defaults.setValue(mPatienRace, forKey: "mPatienRace")
        defaults.setValue(mPatientDoB, forKey: "mPatientDoB")
        defaults.setValue(mPatientGender, forKey: "mPatientGender")
        defaults.setValue(mOwnerName, forKey: "mOwnerName")
        defaults.setValue(mOwnerTel, forKey: "mOwnerTel")
        defaults.setValue(mOwnerEmail, forKey: "mOwnerEmail")
        defaults.setValue(mReason, forKey: "mReason")
        defaults.setValue(mContactByEmail, forKey: "mContactByEmail")
        
        defaults.synchronize()
    }
    
    func clear(){
        clearPatient()
        clearOwner()
        mReason=""
        mContactByEmail=true
    }
    
    func clearPatient(){
        mPatientName=""
        mPatientType=""
        mPatienRace=""
        mPatientDoB=""
        mPatientGender=""
    }
    
    func clearOwner(){
        mOwnerName=""
        mOwnerTel=""
        mOwnerEmail=""
    }
    
    func clearVet(){
        mVetPlace=""
        mVetPractice=""
        mName=""
    }
    
    func validateComplete() -> String {
    // vet data
    if (mVetPractice != nil && mVetPractice!.isEmpty){
        return "Dierenarts - praktijk is niet ingevuld"
    }
        
    // reason is empty
    if (mReason != nil && mReason!.isEmpty){
        return "Reden verwijzing is niet ingevuld"
    }
        
    // patient data
    if (mPatientType != nil && mPatientType!.isEmpty){
        return "Patient - diersoort is niet ingevuld"
    }
        
    // Owner has a name
    if (mOwnerName != nil && mOwnerName!.isEmpty){
        return "Eigenaar - de naam van de eigenaar is niet ingevuld"
    }

        //  owner has either mail or tel number
    if (mOwnerEmail != nil && mOwnerEmail!.isEmpty && mOwnerTel!.isEmpty){
        return "Eigenaar  - contactinformatie ontbreekt"
    }
    
    
    // if we got here, all is cool
    return "Ok";
    }
    
    func toMessage() -> String {
        /*
         Beste Hugo,
         Hierbij verwijs ik door
         <naam patient>, een <type dier - ras> van geslacht <gender>
         
         Het gaat om het volgende: <reason>
         
         Kun je contact opnemen met de eigenaar - naam eigenaar - via email/tel.
         Email: <owner email>.
         Telefoonnummer: <owner tel>.
         
         Vriendelijke groet,
         
         <naam>
         */
        var lines = [String]()
        
        lines.append("Beste Hugo, \n")
        lines.append("Hierbij verwijs ik door:")
        
        if (mPatientName != nil && !(mPatientName!.isEmpty)){
            lines.append("  - patient: \(mPatientName!)")
        }
        if (mPatientType != nil && !(mPatientType!.isEmpty)){
            lines.append("  - soort: \(mPatientType!)")
        }
        if (mPatienRace != nil && !(mPatienRace!.isEmpty)){
            lines.append("  - ras: \(mPatienRace!)")
        }
        if (mPatientGender != nil && !(mPatientGender!.isEmpty)){
            lines.append("  - geslacht: \(mPatientGender!)")
        }
        lines.append("")
        
        if (mReason != nil && !(mReason!.isEmpty)){
            lines.append("Het gaat om het volgende: \(mPatientGender!)")
        }
        lines.append("")
        
        var contact : String
        if (mContactByEmail){
            contact = "email?";
        }
        else {
            contact = "de telefoon?";
        }
        lines.append("Kun je contact opnemen met de eigenaar via \(contact)")
        
        if (mOwnerName != nil && !(mOwnerName!.isEmpty)) {
             lines.append("  - naam: \(mOwnerName!)")
        }
       
        if (mOwnerEmail != nil && !(mOwnerEmail!.isEmpty)){
            lines.append("  - email: \(mOwnerEmail!)")
        }
        if (mOwnerTel != nil && !(mOwnerTel!.isEmpty)){
            lines.append("  - tel: \(mOwnerTel!)")
        }
       
        
        lines.append("")
        lines.append("Vriendelijke groet,")
        lines.append("")
        
        if (mName != nil && !(mName!.isEmpty)){
            lines.append("\(mName!)")
        }
        if (mVetPractice != nil && !(mVetPractice!.isEmpty)){
            lines.append("\(mVetPractice!)")
        }
        if (mVetPlace != nil && !(mVetPlace!.isEmpty)){
            lines.append("\(mVetPlace!)")
        }
        
        var result : String = ""
        for item in lines {
            result = result + "\(item)\n"
        }
        return result;
    }
}













