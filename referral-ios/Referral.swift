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
    var mPatientName : String? // name of the patient
    var mPatientType : String? // type of patient (e.g. Dog, Cat)
    var mPatienRace : String? // race of the patient (e.g. Irish Setter)
    var mPatientDoB : String? // Date of birth of the patient
    var mPatientGender : String? // Gender of patient
    var mOwnerName : String? // name of the owner
    var mOwnerTel : String? // telephone number of the owner
    var mOwnerEmail : String?// email pof the owner
    var mReason : String?
    var mContactByEmail : Bool?
    
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
    
    func getContactByEmail() -> Bool? {
        return mContactByEmail
    }
    
    func setContactByEmail(contactByEmail : Bool?) {
    mContactByEmail = contactByEmail
    }
    
    init() {
        let defaults = UserDefaults.standard
        mName = defaults.string(forKey: "mName")
        mVetPractice = defaults.string(forKey: "mVetPractice")
        mPatientName = defaults.string(forKey: "mPatientName")
        mPatientType = defaults.string(forKey: "mPatientType")
        mPatienRace = defaults.string(forKey: "mPatienRace")
        mPatientDoB = defaults.string(forKey: "mPatientDoB")
        mPatientGender = defaults.string(forKey: "mPatientGender")
        mOwnerName = defaults.string(forKey: "mOwnerName")
        mOwnerTel = defaults.string(forKey: "mOwnerTel")
        mOwnerEmail = defaults.string(forKey: "mOwnerEmail")
        mReason = defaults.string(forKey: "mReason")
        mContactByEmail = defaults.bool(forKey: "mContactByEmail")
    }
    
    func store(){
    
        let defaults = UserDefaults.standard
        defaults.setValue(mName, forKey: "mName")
        defaults.setValue(mVetPractice, forKey: "mVetPractice")
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
        mPatientName=""
        mPatientType=""
        mPatienRace=""
        mPatientDoB=""
        mPatientGender=""
        mOwnerName=""
        mOwnerTel=""
        mOwnerEmail=""
        mReason=""
        mContactByEmail=true
    }
    
    func validateComplete() -> String {
    // vet data
    if (mVetPractice != nil && mVetPractice!.isEmpty){
        return "De praktijk is niet ingevuld"
    }
    // patient data
    if (mPatientType != nil && mPatientType!.isEmpty){
        return "Diersoort is niet ingevuld"
    }
    //  owner has either mail or tel number
    if (mOwnerEmail != nil && mOwnerEmail!.isEmpty && mOwnerTel!.isEmpty){
        return "Eigenaar heeft geen contactinformatie"
    }
    // reason is empty
        if (mReason != nil && mReason!.isEmpty){
            return "Reden verwijzing is niet ingevuld"
        }
    
    // if we got here, all is cool
    return "Ok";
    }
    
    func toMessage() -> String {
        //TODO
        return "TDOO"
    }
}













