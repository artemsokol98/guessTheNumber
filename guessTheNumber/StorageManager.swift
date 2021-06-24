//
//  StorageManager.swift
//  guessTheNumber
//
//  Created by Артем Соколовский on 24.06.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    let userDefaults = UserDefaults.standard
    
    func save(number: Int, key: String) {
        userDefaults.set(number, forKey: key)
    }
    
    func fetch(key: String) -> Int {
        userDefaults.integer(forKey: key)
    }
    
    private init() {}
}
