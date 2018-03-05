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
    var mVetEmail : String? // email address of bvet
    var mPatientName : String? // name of the patient
    var mPatientType : String? // type of patient (e.g. Dog, Cat)
    var mPatienRace : String? // race of the patient (e.g. Irish Setter)
    var mPatientDoB : String? // Date of birth of the patient
    var mPatientGender : String? // Gender of patient
    var mOwnerName : String? // name of the owner
    var mOwnerTel : String? // telephone number of the owner
    var mOwnerEmail : String?// email of the owner
    var mReason : String? // referral reason
    var mIsRecordedReason : Bool // indicates (true) if a reason was recorded
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
    
    
    func getVetEmail() -> String?  {
        return mVetEmail
    }
    
    func setVetEmail(vetEmail: String?) {
        mVetEmail = vetEmail
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
    
    func getIsRecordedReason() -> Bool {
        return mIsRecordedReason
    }
    
    func setIsRecordedReason( isRecordedReason: Bool) {
        mIsRecordedReason = isRecordedReason
    }
    
    init() {
        let defaults = UserDefaults.standard
        mName = defaults.string(forKey: "mName")
        mVetPractice = defaults.string(forKey: "mVetPractice")
        mVetPlace = defaults.string(forKey: "mVetPlace")
        mVetEmail = defaults.string(forKey: "mVetEmail")
        mPatientName = defaults.string(forKey: "mPatientName")
        mPatientType = defaults.string(forKey: "mPatientType")
        mPatienRace = defaults.string(forKey: "mPatienRace")
        mPatientDoB = defaults.string(forKey: "mPatientDoB")
        mPatientGender = defaults.string(forKey: "mPatientGender")
        mOwnerName = defaults.string(forKey: "mOwnerName")
        mOwnerTel = defaults.string(forKey: "mOwnerTel")
        mOwnerEmail = defaults.string(forKey: "mOwnerEmail")
        mReason = defaults.string(forKey: "mReason")
        let isRecordedReason = defaults.object(forKey: "mIsRecordedReason")
        if (isRecordedReason != nil) {
            mIsRecordedReason = isRecordedReason as! Bool
        }
        else {
            mIsRecordedReason = false // defaults to false
        }
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
            let vetemail = json["vetemail"] as? String,
            let patientname = json["patientname"] as? String,
            let patienttype = json["patienttype"] as? String,
            let patientrace = json["patientrace"] as? String,
            let patientdob = json["patientdob"] as? String,
            let patientgender = json["patientgender"] as? String,
            let ownername = json["ownername"] as? String,
            let ownertel = json["ownertel"] as? String,
            let owneremail = json["owneremail"] as? String,
            let reason = json["reason"] as? String,
            let isrecordedreason = json["isrecordedreason"] as? Bool,
            let contactbyemail = json["contactbyemail"] as? Bool
            else {
                return nil
            }
        
        mName = name
        mVetPractice = vetpractice
        mVetPlace = vetplace
        mVetEmail = vetemail
        mPatientName = patientname
        mPatientType = patienttype
        mPatienRace = patientrace
        mPatientDoB = patientdob
        mPatientGender = patientgender
        mOwnerName = ownername
        mOwnerTel = ownertel
        mOwnerEmail = owneremail
        mReason = reason
        mIsRecordedReason = isrecordedreason
        mContactByEmail = contactbyemail
        
    }
    
    func toJson() -> NSDictionary {
        let json:NSMutableDictionary = NSMutableDictionary()
        json.setValue(mName, forKey: "name")
        json.setValue(mVetPractice, forKey: "vetpractice")
        json.setValue(mVetPlace, forKey: "vetplace")
        json.setValue(mVetEmail, forKey: "vetemail")
        json.setValue(mPatientName, forKey: "patientname")
        json.setValue(mPatientType, forKey: "patienttype")
        json.setValue(mPatienRace, forKey: "patientrace")
        json.setValue(mPatientDoB, forKey: "patientdob")
        json.setValue(mPatientGender, forKey: "patientgender")
        json.setValue(mOwnerName, forKey: "ownername")
        json.setValue(mOwnerTel, forKey: "ownertel")
        json.setValue(mOwnerEmail, forKey: "owneremail")
        json.setValue(mReason, forKey: "reason")
        json.setValue(mIsRecordedReason, forKey: "isrecordedreason")
        json.setValue(mContactByEmail, forKey: "contactbyemail")
        return json
    }
    
    func store(){
    
        let defaults = UserDefaults.standard
        defaults.setValue(mName, forKey: "mName")
        defaults.setValue(mVetPractice, forKey: "mVetPractice")
        defaults.setValue(mVetPlace, forKey: "mVetPlace")
        defaults.setValue(mVetEmail, forKey: "mVetEmail")
        defaults.setValue(mPatientName, forKey: "mPatientName")
        defaults.setValue(mPatientType, forKey: "mPatientType")
        defaults.setValue(mPatienRace, forKey: "mPatienRace")
        defaults.setValue(mPatientDoB, forKey: "mPatientDoB")
        defaults.setValue(mPatientGender, forKey: "mPatientGender")
        defaults.setValue(mOwnerName, forKey: "mOwnerName")
        defaults.setValue(mOwnerTel, forKey: "mOwnerTel")
        defaults.setValue(mOwnerEmail, forKey: "mOwnerEmail")
        defaults.setValue(mReason, forKey: "mReason")
        defaults.setValue(mIsRecordedReason, forKey: "mIsRecordedReason")
        defaults.setValue(mContactByEmail, forKey: "mContactByEmail")
        
        defaults.synchronize()
    }
    
    func clear(){
        clearPatient()
        clearOwner()
        mReason=""
        mIsRecordedReason=false
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
        mVetEmail=""
        mVetPractice=""
        mName=""
    }
    
    func clearReason(){
        mReason=""
        mIsRecordedReason=false
    }
    
    
    func validateComplete() -> String {
    // vet data
    if (mVetPractice != nil && mVetPractice!.isEmpty){
        return "Dierenarts - praktijk is niet ingevuld"
    }
        
    if (mVetEmail != nil && mVetEmail!.isEmpty){
        return "Dierenarts - email adres is niet ingevuld"
    }
        
    // reason is empty
    if ((mReason != nil && mReason!.isEmpty) && !mIsRecordedReason){
        return "Reden verwijzing is niet ingevuld / niet opgenomen"
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
        
        lines.append("<p>")
        lines.append("Beste Hugo, \n")
        lines.append("</p>")
        
        lines.append("<br>")
        
        lines.append("<p>")
        lines.append("Hierbij verwijs ik door:")
        lines.append("</p>")
        
        lines.append("<ul>")
        if (mPatientName != nil && !(mPatientName!.isEmpty)){
            lines.append("<li>")
            lines.append("patient: \(mPatientName!)")
            lines.append("</li>")
        }
        if (mPatientType != nil && !(mPatientType!.isEmpty)){
            lines.append("<li>")
            lines.append("soort: \(mPatientType!)")
            lines.append("</li>")
        }
        if (mPatienRace != nil && !(mPatienRace!.isEmpty)){
            lines.append("<li>")
            lines.append("ras: \(mPatienRace!)")
            lines.append("</li>")
        }
        if (mPatientGender != nil && !(mPatientGender!.isEmpty)){
            lines.append("<li>")
            lines.append("geslacht: \(mPatientGender!)")
            lines.append("</li>")
        }
        
        lines.append("</ul>")
        
        if (mReason != nil && !(mReason!.isEmpty)){
            lines.append("<p>")
            lines.append("Het gaat om het volgende: \(mReason!)")
            lines.append("</p>")
        }
        
        var contact : String
        if (mContactByEmail){
            contact = "email?";
        }
        else {
            contact = "de telefoon?";
        }
        lines.append("<p>")
        lines.append("Kun je contact opnemen met de eigenaar via \(contact)")
        lines.append("</p>")
        lines.append("<ul>")
        if (mOwnerName != nil && !(mOwnerName!.isEmpty)) {
            lines.append("<li>")
             lines.append("naam: \(mOwnerName!)")
             lines.append("</li>")
        }
       
        if (mOwnerEmail != nil && !(mOwnerEmail!.isEmpty)){
             lines.append("<li>")
            lines.append("email: \(mOwnerEmail!)")
             lines.append("</li>")
        }
        if (mOwnerTel != nil && !(mOwnerTel!.isEmpty)){
             lines.append("<li>")
            lines.append("tel: \(mOwnerTel!)")
             lines.append("</li>")
        }
        lines.append("</ul>")
        
        
        lines.append("<p>")
        lines.append("Vriendelijke groet,")
        lines.append("<br>")
    
        
        
        if (mName != nil && !(mName!.isEmpty)){
            lines.append("\(mName!)")
            lines.append("<br>")
        }
        if (mVetEmail != nil && !(mVetEmail!.isEmpty)){
            lines.append("\(mVetEmail!)")
            lines.append("<br>")
        }
        if (mVetPractice != nil && !(mVetPractice!.isEmpty)){
            lines.append("\(mVetPractice!)")
            lines.append("<br>")
        }
        if (mVetPlace != nil && !(mVetPlace!.isEmpty)){
            lines.append("\(mVetPlace!)")
            lines.append("<br>")
        }
        lines.append("</p>")
        
        var result : String = ""
        for item in lines {
            result = result + "\(item)\n"
        }
        
        return result;
    }
}













