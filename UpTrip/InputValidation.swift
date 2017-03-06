//
//  inputValidation.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/21/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation

class InputValidation {
    
    func isValidEmail(email: String?) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        return result
    }
    
    func isValidPhoneNumber(number: String?) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: number)
        
        return result
    }
    
    func isValidAccountNumber(number: String?) -> Bool {
        let ACCOUNT_REGEX = "^\\d{4}-\\d{4}-\\d{4}-\\d{4}$"
        let accountTest = NSPredicate(format: "SELF MATCHES%@", ACCOUNT_REGEX)
        let result = accountTest.evaluate(with: number)
        
        return result
    }
    
    func isValidExp(number: String?) -> Bool {
        let DATE_REGEX = "^\\d{2}/\\d{2}$"
        let dateTest = NSPredicate(format: "SELF MATCHES%@", DATE_REGEX)
        let result = dateTest.evaluate(with: number)
        
        return result
    }
    
    func isValidCVC(number: String?) -> Bool {
        let CVC_REGEX = "^\\d{3}$"
        let cvcTest = NSPredicate(format: "SELF MATCHES%@", CVC_REGEX)
        let result = cvcTest.evaluate(with: number)
        
        return result
    }
    
    func gsubStringToNumber(string: String?) -> String {
        let newString = string?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        return newString!
    }
    
}
