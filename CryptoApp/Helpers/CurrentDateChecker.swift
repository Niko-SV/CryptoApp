//
//  CurrentDateChecker.swift
//  CryptoApp
//
//  Created by NikoS on 14.10.2022.
//

import Foundation

final class CurrentDateChecker {
    
    
    func setData() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        let time =  formatter.string(from: currentDateTime)
        UserDefaults.standard.set(time, forKey: "currentTime")
    }
    
    func getData() -> String {
        let time = UserDefaults.standard.string(forKey: "currentTime") ?? ""
        return time
    }
    
    func setHourlyArray() {
        var eachHour = [String]()
        var i = 24
        var j = Calendar.current.component(.hour, from: Date()) + 1
        for _ in 0...23 {
            j -= 1
            eachHour.append(String(j) + Constants.zeroMinutes)
            i -= 1
            if (j <= 0) {
                j = 24
            }
        }
        UserDefaults.standard.set(eachHour, forKey: "eachHour")
    }
    
    func getHourlyArray() -> Array<String> {
        let time = UserDefaults.standard.stringArray(forKey: "eachHour") ?? []
        return time
    }
    
}
