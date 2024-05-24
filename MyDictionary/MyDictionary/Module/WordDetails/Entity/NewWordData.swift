//
//  NewWordData.swift
//  MyDictionary
//
//  Created by murat albayrak on 23.05.2024.
//

import Foundation

struct NewWordData: Decodable, Hashable {
    var newPartOfSpeech: String?
    var newDefinition: String?
    var newExample: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(newPartOfSpeech)
        hasher.combine(newDefinition)
        hasher.combine(newExample)
    }
    
    static func == (lhs: NewWordData, rhs: NewWordData) -> Bool {
        return lhs.newPartOfSpeech == rhs.newPartOfSpeech &&
               lhs.newDefinition == rhs.newDefinition &&
               lhs.newExample == rhs.newExample
    }
}
