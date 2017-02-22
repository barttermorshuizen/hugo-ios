//
//  PetActivity.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 22/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit

class PetController : UIViewController {
    var referral : Referral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Patient"
        
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
    
    func modelToView(){
        // copies the model in the view
        
    }
    
    func viewToModel() {
        referral!.store();
    }
}
