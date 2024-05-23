//
//  NewWordData.swift
//  MyDictionary
//
//  Created by murat albayrak on 23.05.2024.
//

import Foundation

public struct NewWordData: Decodable, Hashable {
    public var newPartOfSpeech: String?
    public var newDefinition: String?
    public var newExample: String?
    public var audio: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(newPartOfSpeech)
        hasher.combine(newDefinition)
        hasher.combine(newExample)
        hasher.combine(audio)
    }
    
    public static func == (lhs: NewWordData, rhs: NewWordData) -> Bool {
        return lhs.newPartOfSpeech == rhs.newPartOfSpeech &&
               lhs.newDefinition == rhs.newDefinition &&
               lhs.newExample == rhs.newExample &&
        
        
    }
}
