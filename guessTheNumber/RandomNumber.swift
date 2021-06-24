//
//  RandomNumber.swift
//  guessTheNumber
//
//  Created by Артем Соколовский on 23.06.2021.
//

import Foundation

struct RandomNumber {
    var minimumValue: Int
    var maximumValue: Int
    
    var randomValue: Int {
        Int.random(in: minimumValue...maximumValue)
    }
}
