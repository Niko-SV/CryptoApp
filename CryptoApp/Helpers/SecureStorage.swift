//
//  SecureStorage.swift
//  CryptoApp
//
//  Created by NikoS on 14.10.2022.
//

import Foundation
import KeychainAccess

final class SecureStorage {
    
    enum Keys {
        static let email = "Email"
        static let password = "Password"
        static let token = "Token"
    }

    private let keychain = Keychain(service: "CryptoApp")

    func put(object: String, for key: String) throws {
        try keychain.set(object, key: key)
    }

    func get(key: String) throws -> String? {
        try keychain.get(key)
    }

}

enum MyProjectError: Error {
    case unknown
}
