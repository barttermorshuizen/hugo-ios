//
//  Call.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 24/02/2017.
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import Foundation
import UIKit

class Call {
    static func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
            }
        }
    }
}
