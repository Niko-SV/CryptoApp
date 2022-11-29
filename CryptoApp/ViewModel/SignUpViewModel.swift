//
//  SignUpViewModel.swift
//  CryptoApp
//
//  Created by NikoS on 10.02.2022.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    var emailError = ""
    var passwordError = ""
    var confirmPasswordError = ""
    
    // MARK: Validation
    
    func passwordsMatch() -> Bool {
        password == confirmPassword
    }
    
    // MARK: Password validator Requires 6-20 characters including at least 1 upper or lower alpha, and 1 digit. It should disallow just about everything else, inluding extended characters.
    
    func isPasswordValid() -> Bool {
         let passwordTest = NSPredicate(format: "SELF MATCHES %@",
         "^(?=.*\\d)(?=.*[a-zA-Z])(?!.*[\\W_\\x7B-\\xFF]).{6,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: Email validator that adheres directly to the specification for email address naming. It allows for everything from ipaddress and country-code domains, to very rare characters in the username.
    
    func isEmailValid() -> Bool {
         let emailTest = NSPredicate(format: "SELF MATCHES %@",
         "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    //MARK: Validation Prompt Settings
    
    var emailPrompt: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }
    
    var passwordPrompt: String {
        if isPasswordValid() {
            return ""
        } else {
            return "Must be 6-20 characters including at least 1 upper or lower alpha, and 1 digit"
        }
    }
    
    var confirmPasswordPrompt: String {
        if passwordsMatch() {
            return ""
        } else {
            return "Password firelds do not match"
        }
    }
}
