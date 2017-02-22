//
//  VetController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 20/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class VetController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mEditTextName: UITextField!
    @IBOutlet weak var mSpinnerVets: UIPickerView!
    
    var referral : Referral?
    
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Dierenarts"
        
        referral = Referral()
        
        pickerData = ["DierenDokters Amsterdam", "Caressa Amsterdam", "Dierenkliniek De Jordaan", "Dierenkliniek Westerpark","Dierenkliniek Centrum-Oost Amsterdam","Dierenkliniek de Wetering","Dierenartspraktijk Centrum en West Amsterdam","Dierenkliniek Vondelpark"]
        
        self.mSpinnerVets.delegate = self
        self.mSpinnerVets.dataSource = self

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
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func modelToView(){
        // copies the model in the view
        mEditTextName.text = referral!.getName();
        
        if (referral!.getVetPractice() != nil){
            let pos : Int? = pickerData.index(of: referral!.getVetPractice()!)
            if (pos != nil){
                mSpinnerVets.selectRow(pos!, inComponent: 0, animated: false)
            }
        }
        
    }
    
    func viewToModel() {
        // only pushes the vet and name preferences to the model.
        referral!.setName(name: mEditTextName.text)
        let pos:Int = mSpinnerVets.selectedRow(inComponent: 0);
        referral!.setVetPractice(vetPractice: pickerView(mSpinnerVets, titleForRow: pos, forComponent: 0))
        referral!.store();
    }
}
