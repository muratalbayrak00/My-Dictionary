//
//  WordsData.swift
//
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

public struct WordsData: Decodable {
    
    public let word, phonetic: String?
    public let phonetics: [Phonetic]?
    public var meanings: [Meaning]?
    
    public var totalDefinitionsCount: Int {
        return meanings?.reduce(0) { $0 + ($1.definitions?.count ?? 0) } ?? 0
    }
    
    public var combinedMeanings: [Meaning] {
        return meanings ?? []
    }
}

public struct Meaning: Decodable {
    public var partOfSpeech: String?
    public var definitions: [Definition]?
}

public struct Definition: Decodable {
    public let definition: String?
    public let example: String?
    
    enum CodingKeys: String, CodingKey {
        case definition
        case example
    }
}

public struct Phonetic: Decodable {
    public let audio: String?
    
    public enum CodingKeys: String, CodingKey {
        case audio

    }
}
